import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/session_model.dart';
import '../../data/session_repository.dart';

final sessionRepositoryProvider =
    Provider<SessionRepository>(
  (ref) => SessionRepository(),
);

final sessionProvider =
    FutureProvider<List<SessionModel>>(
  (ref) async {
    return ref
        .read(sessionRepositoryProvider)
        .getSessions();
  },
);