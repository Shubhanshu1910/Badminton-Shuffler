import 'package:badminton_shuffler_app/features/home/data/models/round_response.dart';
import 'package:dio/dio.dart';

import '../../../../core/api/api_client.dart';

class SessionApi {
  final Dio dio = ApiClient.dio;

  Future<List<dynamic>> getSessions() async {
    final response = await dio.get("/sessions");

    return response.data["data"];
  }

  Future<dynamic> getSession(
    String id,
  ) async {
    final response =
        await dio.get("/sessions/$id");

    return response.data["data"];
  }

  Future<dynamic> createSession(
    Map<String, dynamic> body,
  ) async {
    final response = await dio.post(
      "/sessions",
      data: body,
    );

    return response.data["data"];
  }

  Future<dynamic> updateSession(
    String id,
    Map<String, dynamic> body,
  ) async {
    final response = await dio.patch(
      "/sessions/$id",
      data: body,
    );

    return response.data["data"];
  }

  Future<void> deleteSession(
    String id,
  ) async {
    await dio.delete("/sessions/$id");
  }

  Future<void> addPlayers(
    String id,
    List<String> players,
  ) async {
    await dio.post(
      "/sessions/$id/players",
      data: {
        "playerIds": players,
      },
    );
  }

  Future<void> addCourts(
    String id,
    List<String> courts,
  ) async {
    await dio.post(
      "/sessions/$id/courts",
      data: {
        "courtIds": courts,
      },
    );
  }

  Future<dynamic> startSession(
    String id,
  ) async {
    final response =
        await dio.post("/sessions/$id/start");

    return response.data["data"];
  }

  Future<RoundResponse> generateRound(
    String sessionId) async {
  final response = await dio.post(
    "/rounds/$sessionId/generate",
  );

  return RoundResponse.fromJson(
    response.data["data"],
  );
}

Future<RoundResponse> getCurrentRound(
  String sessionId,
) async {
  final response = await dio.get(
    "/rounds/$sessionId/current",
  );

  return RoundResponse.fromJson(
    response.data["data"],
  );
}
}