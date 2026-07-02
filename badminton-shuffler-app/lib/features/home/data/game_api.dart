import 'package:dio/dio.dart';
import '../../../core/api/api_client.dart';

class GameApi {
  final Dio dio = ApiClient.dio;

  Future<void> startGame(String matchId) async {
    await dio.post(
      "/game/start",
      data: {
        "matchId": matchId,
      },
    );
  }

  Future<void> updateScore(
    String matchId,
    int scoreA,
    int scoreB,
  ) async {
    await dio.patch(
      "/game/$matchId/score",
      data: {
        "teamAScore": scoreA,
        "teamBScore": scoreB,
      },
    );
  }

  Future<void> finishGame(
    String matchId,
    int winner,
  ) async {
    await dio.post(
      "/game/$matchId/finish",
      data: {
        "winner": winner,
      },
    );
  }
}