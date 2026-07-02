import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/game_repository.dart';

final gameRepositoryProvider =
    Provider<GameRepository>(
  (ref) => GameRepository(),
);