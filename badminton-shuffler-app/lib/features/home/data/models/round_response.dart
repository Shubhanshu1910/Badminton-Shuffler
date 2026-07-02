import 'match_model.dart';
import 'player_match_model.dart';
import 'round_model.dart';

class RoundResponse {
  final RoundModel round;
  final List<MatchModel> matches;
  final List<PlayerMatchModel> waitingPlayers;

  RoundResponse({
    required this.round,
    required this.matches,
    required this.waitingPlayers,
  });

  factory RoundResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return RoundResponse(
      // Current endpoint returns the round itself
      round: RoundModel.fromJson(json),

      matches: (json["matches"] as List? ?? [])
          .map((e) => MatchModel.fromJson(e))
          .toList(),

      // Current endpoint doesn't return waitingPlayers
      waitingPlayers:
          (json["waitingPlayers"] as List? ?? [])
              .map((e) =>
                  PlayerMatchModel.fromJson(e))
              .toList(),
    );
  }
}