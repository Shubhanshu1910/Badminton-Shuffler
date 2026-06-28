Here are the answers, drawn directly from the PRD:

**What problem does the app solve?**

When a group of badminton players shows up to play, someone has to figure out who plays who, on which court, and in what order — and they have to do it again after every match. That process is almost always manual, slow, and unfair. Popular or assertive players end up playing more games. Friends keep pairing with the same partners. The person coordinating wastes 10–15 minutes per rotation negotiating or guessing. And nobody has any record of what actually happened during the session. Badminton Shuffler automates all of that: it tracks every player's game count, wait time, partner history, and opponent history, then uses that data to generate the fairest possible next match automatically.

**Who will use it?**

Primarily club coordinators — the person in any group who takes responsibility for organising who plays when. They're the core user because they feel the coordination pain most directly. Beyond them: casual friend groups playing weekend badminton who want equal court time without arguments, sports centre staff running drop-in sessions, coaches managing training squads who need varied pairings, and competitive club members who want stats and session history tracked over time.

**What is the MVP?**

The v1.0 MVP is a fully offline mobile app that covers the complete session lifecycle end to end. A coordinator creates a session with a name, court count, and match duration. They add players by name. The app generates fair team assignments across all courts using the rotation algorithm, runs a countdown timer per match, lets the coordinator record which team won, then automatically recalculates and presents the next rotation. A statistics screen at the end of the session shows each player's games played, waiting rounds, and win rate. That full loop — create, add players, generate, play, result, rotate, repeat, summarise — is the MVP. Everything runs on-device with no account or internet connection required.

**What features are not included in v1?**

Quite a lot was deliberately deferred to keep v1 shippable. There are no persistent player profiles — every session starts fresh with no memory of previous sessions. There is no skill rating system or ELO scoring, so teams are assigned for fairness in rotation count rather than competitive balance. There is no multi-device sync, so only one phone can coordinate a session. There is no way to export results to PDF or CSV. Push notifications to individual players' phones are not included. Club roster management — maintaining a standing list of regular members across weeks — is a v2 feature. Tournament bracket mode, social sharing, and the subscription paywall are all v3 or later. The backend, cloud database, and real-time sync infrastructure don't exist in v1 at all; the app is entirely local SQLite.

