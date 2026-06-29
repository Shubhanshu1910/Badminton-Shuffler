import 'models/session_model.dart';
import 'session_api.dart';

class SessionRepository {
  final api = SessionApi();

  Future<List<SessionModel>> getSessions() async {
    final data = await api.getSessions();

    return data
        .map((e) => SessionModel.fromJson(e))
        .toList();
  }
}