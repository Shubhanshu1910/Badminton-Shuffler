import '../api/player_api.dart';
import '../models/player_model.dart';

class PlayerRepository {
  final api = PlayerApi();

  Future<List<PlayerModel>> getPlayers() async {
    final data = await api.getPlayers();

    return data
        .map<PlayerModel>(
          (e) => PlayerModel.fromJson(e),
        )
        .toList();
  }
}