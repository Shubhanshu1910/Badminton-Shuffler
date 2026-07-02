import '../api/court_api.dart';
import '../models/court_model.dart';

class CourtRepository {
  final CourtApi api = CourtApi();

  Future<List<CourtModel>> getCourts() async {
    final data = await api.getCourts();

    return (data as List)
        .map((e) => CourtModel.fromJson(e))
        .toList();
  }

  Future<void> createCourt({
    required String name,
    required int courtNumber,
  }) {
    return api.createCourt({
      "name": name,
      "courtNumber": courtNumber,
    });
  }

  Future<void> updateCourt(
    String id,
    String name,
    int courtNumber,
  ) {
    return api.updateCourt(id, {
      "name": name,
      "courtNumber": courtNumber,
    });
  }

  Future<void> deleteCourt(String id) {
    return api.deleteCourt(id);
  }
}