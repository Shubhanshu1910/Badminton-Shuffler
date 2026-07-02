import '../api/player_api.dart';
import '../models/player_model.dart';

class PlayerRepository {
  final PlayerApi api = PlayerApi();

  Future<List<PlayerModel>> getPlayers() async {
    final data = await api.getPlayers();

    return (data as List)
        .map((e) => PlayerModel.fromJson(e))
        .toList();
  }

  Future<void> createPlayer({
    required String name,
    required String phone,
    required int skill,
  }) {
    return api.createPlayer({
      "name": name,
      "phone": phone,
      "skillLevel": skill,
    });
  }

  Future<void> updatePlayer(
    String id,
    String name,
    String phone,
    int skill,
  ) {
    return api.updatePlayer(id, {
      "name": name,
      "phone": phone,
      "skillLevel": skill,
    });
  }

  Future<void> deletePlayer(String id) {
    return api.deletePlayer(id);
  }
}