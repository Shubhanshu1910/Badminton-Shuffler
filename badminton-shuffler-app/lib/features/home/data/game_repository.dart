import 'game_api.dart';

class GameRepository {
  final api = GameApi();

  Future<void> startGame(String id) {
    return api.startGame(id);
  }

  Future<void> updateScore(
    String id,
    int scoreA,
    int scoreB,
  ) {
    return api.updateScore(
      id,
      scoreA,
      scoreB,
    );
  }

  Future<void> finishGame(
    String id,
    int winner,
  ) {
    return api.finishGame(
      id,
      winner,
    );
  }
}