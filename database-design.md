The ERD guidance tells me to use mermaid.js for database schemas. Let me build a rich interactive ERD with full field details.
Here is the full breakdown of every model — fields, types, and how they connect.

Session
The root of everything. A session is one physical playing occasion — a Sunday club, a Friday group, a training session. Every other table hangs off it.
FieldTypeNotesidTEXT (UUID)Primary keynameTEXTe.g. "Sunday Club — 22 Jun"courtsINTEGERNumber of active courts (1–10)duration_secondsINTEGERLength of each match, e.g. 900 for 15 minrotation_typeTEXT'round_robin' or 'random'statusTEXT'active' or 'completed'created_atINTEGERUnix timestampended_atINTEGERUnix timestamp, null until session ends
Relationships: one Session → many Players, Courts, Rounds, Queue entries. One Session → one Statistics summary.

Player
One person participating in the session. Carries live counters that the algorithm reads on every rotation.
FieldTypeNotesidTEXT (UUID)Primary keysession_idTEXTFK → Session.idnameTEXTDisplay namecolorTEXTHex accent color, e.g. #1565C0initialTEXT1–2 chars derived from name, e.g. "AR"games_playedINTEGERCount of completed matches this sessiongames_wonINTEGERCount of won matcheswait_countINTEGERCount of rounds spent in the queuelast_played_roundINTEGERRound number of most recent match — used to break ties in the algorithmstatusTEXT'active', 'playing', 'waiting', or 'inactive'added_atINTEGERUnix timestamp — for late joiners, initialised to the session average games_played
Relationships: belongs to one Session. Appears in many Teams and many Queue entries. Has one Statistics record.

Court
A physical court within the session. Tracks which match is currently live on it.
FieldTypeNotesidTEXT (UUID)Primary keysession_idTEXTFK → Session.idcourt_numberINTEGER1-indexed, e.g. 1, 2, 3statusTEXT'idle', 'live', or 'paused'current_match_idTEXTFK → Match.id, null when idle
Relationships: belongs to one Session. Hosts many Matches over time.

Round
One complete cycle across all courts — all courts play simultaneously within a single round. The timer belongs to the round, not to individual matches.
FieldTypeNotesidTEXT (UUID)Primary keysession_idTEXTFK → Session.idround_numberINTEGERSequential, 1-indexedstatusTEXT'pending', 'live', or 'completed'started_atINTEGERUnix timestamp — persisted so timer survives app killended_atINTEGERUnix timestamp, null until round completes
Relationships: belongs to one Session. Contains many Matches (one per court per round).

Match
One specific game on one specific court within one round. Holds the result.
FieldTypeNotesidTEXT (UUID)Primary keyround_idTEXTFK → Round.idcourt_idTEXTFK → Court.idwinnerTEXT'team_a', 'team_b', or null if skippedskippedBOOLEANTrue if coordinator tapped "skip result"completed_atINTEGERUnix timestamp
Relationships: belongs to one Round and one Court. Has exactly two Teams.

Team
One side in a Match — always exactly two players. Keeping this as its own table (rather than storing player IDs directly on Match) makes partner-history queries clean and makes it trivial to extend to 3v3 later.
FieldTypeNotesidTEXT (UUID)Primary keymatch_idTEXTFK → Match.idlabelTEXT'team_a' or 'team_b'player_a_idTEXTFK → Player.idplayer_b_idTEXTFK → Player.idis_winnerBOOLEANDenormalized for fast reads — mirrors Match.winner
Relationships: belongs to one Match. References two Players.

Queue
The ordered waiting list at any point in the session. This is a live table — rows are inserted and deleted as players rotate in and out of courts.
FieldTypeNotesidTEXT (UUID)Primary keysession_idTEXTFK → Session.idplayer_idTEXTFK → Player.idpositionINTEGERSort order — lower = plays sooner. Recalculated after each rotationwait_since_roundINTEGERThe round number when this player last entered the queuereasonTEXT'rotation' (normal), 'late_join', or 'manual' (coordinator override)
Relationships: belongs to one Session. References one Player per row.

Statistics
A per-player aggregate record for the session, materialised after each round for fast reads on the stats screen. Stored as a single row per player rather than computed on the fly from the match tables, since the stats screen needs to show all players simultaneously.
FieldTypeNotesidTEXT (UUID)Primary keyplayer_idTEXTFK → Player.idsession_idTEXTFK → Session.idtotal_gamesINTEGERMatches playedtotal_winsINTEGERMatches wontotal_waitsINTEGERRounds spent in queuewin_rateREALtotal_wins / total_games, 0.0–1.0fairness_deltaREALDifference from the session average games_played — lower is fairerpartner_historyTEXTJSON map of { player_id: count } — how many times partnered with each other playeropponent_historyTEXTJSON map of { player_id: count } — how many times opposed each other player
Relationships: belongs to one Player and one Session. Updated after every completeRound() call.

Key design decisions worth noting
partner_history and opponent_history are stored as JSON on the Statistics row rather than as a separate junction table. For a session with up to 20 players that's a map of at most 19 entries — tiny. A full junction table would add query complexity with no practical gain at this scale. If the app grows to multi-session lifetime stats in v2, those move to a proper player_history table with a composite primary key of (player_a_id, player_b_id) and a < b enforced to avoid duplicates.
The Queue table uses a position integer rather than a linked list. Reordering on manual override is a single UPDATE ... SET position = ? per affected row rather than pointer surgery.
Round owns the timer start timestamp (started_at), not Match. All courts in a session start and end simultaneously — there is no per-court timer, so the timestamp lives one level up.


