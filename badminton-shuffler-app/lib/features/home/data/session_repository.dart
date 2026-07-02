

import 'package:badminton_shuffler_app/features/home/data/models/round_response.dart';
import 'package:badminton_shuffler_app/features/home/data/models/session_model.dart';
import 'package:badminton_shuffler_app/features/home/data/session_api.dart';

class SessionRepository {
  final SessionApi api = SessionApi();

  Future<List<SessionModel>> getSessions() async {
    final data = await api.getSessions();

    return (data as List)
        .map(
          (e) => SessionModel.fromJson(e),
        )
        .toList();
  }

  Future<void> createSession({
    required String title,
    required String description,
    required int totalCourts,
    required int maxPlayers,
  }) {
    return api.createSession({
      "title": title,
      "description": description,
      "totalCourts": totalCourts,
      "maxPlayers": maxPlayers,
    });
  }

  Future<void> updateSession(
    String id,
    String title,
    String description,
    int totalCourts,
    int maxPlayers,
  ) {
    return api.updateSession(id, {
      "title": title,
      "description": description,
      "totalCourts": totalCourts,
      "maxPlayers": maxPlayers,
    });
  }

  Future<void> deleteSession(
    String id,
  ) {
    return api.deleteSession(id);
  }

  Future<void> addPlayers(
    String id,
    List<String> playerIds,
  ) {
    return api.addPlayers(
      id,
      playerIds,
    );
  }

  Future<void> addCourts(
    String id,
    List<String> courtIds,
  ) {
    return api.addCourts(
      id,
      courtIds,
    );
  }

  Future<void> startSession(
    String id,
  ) {
    return api.startSession(id);
  }

  Future<RoundResponse> generateRound(
    String sessionId) {
  return api.generateRound(sessionId);
}

Future<RoundResponse> getCurrentRound(
  String sessionId,
) {
  return api.getCurrentRound(
    sessionId,
  );
}
}