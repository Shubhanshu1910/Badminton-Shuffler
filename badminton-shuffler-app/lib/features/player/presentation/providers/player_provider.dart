import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/player_model.dart';
import '../../data/repositories/player_repository.dart';

final playerRepositoryProvider =
    Provider<PlayerRepository>(
  (ref) => PlayerRepository(),
);

final playerProvider =
    FutureProvider<List<PlayerModel>>(
  (ref) {
    return ref
        .watch(playerRepositoryProvider)
        .getPlayers();
  },
);