import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/court_model.dart';
import '../../data/repositories/court_repository.dart';

final courtRepositoryProvider =
    Provider<CourtRepository>((ref) {
  return CourtRepository();
});

final courtProvider =
    FutureProvider<List<CourtModel>>((ref) async {
  return ref
      .read(courtRepositoryProvider)
      .getCourts();
});