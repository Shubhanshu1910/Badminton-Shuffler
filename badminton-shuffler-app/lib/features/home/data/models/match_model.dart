import 'player_match_model.dart';

class MatchModel {
  final String matchId;
  final String courtId;
  final int courtNumber;

  final List<PlayerMatchModel> teamA;
  final List<PlayerMatchModel> teamB;
  final List<PlayerMatchModel> players;

  MatchModel({
    required this.matchId,
    required this.courtId,
    required this.courtNumber,
    required this.teamA,
    required this.teamB,
    required this.players,
  });

  factory MatchModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final players =
        (json["players"] as List? ?? [])
            .map(
              (e) => PlayerMatchModel.fromJson(e),
            )
            .toList();

    return MatchModel(
      matchId: json["matchId"] ?? json["id"],
      courtId: json["courtId"],

      courtNumber:
          json["courtNumber"] ??
              json["court"]?["courtNumber"] ??
              0,

      players: players,

      teamA: players
          .where((e) => e.team == 1)
          .toList(),

      teamB: players
          .where((e) => e.team == 2)
          .toList(),
    );
  }
}