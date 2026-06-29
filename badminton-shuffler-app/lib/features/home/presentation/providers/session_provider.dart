import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/session_repository.dart';
import '../../data/models/session_model.dart';

final sessionProvider =
    FutureProvider<List<SessionModel>>((ref) async {
  return SessionRepository().getSessions();
});