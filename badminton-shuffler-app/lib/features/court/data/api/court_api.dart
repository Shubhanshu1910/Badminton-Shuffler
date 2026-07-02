import 'package:dio/dio.dart';

import '../../../../core/api/api_client.dart';

class CourtApi {
  final Dio dio = ApiClient.dio;

  Future<List<dynamic>> getCourts() async {
    final response = await dio.get('/courts');

    return response.data['data']['items'];
  }

  Future<dynamic> createCourt(
      Map<String, dynamic> body) async {
    final response = await dio.post(
      '/courts',
      data: body,
    );

    return response.data['data'];
  }

  Future<dynamic> updateCourt(
      String id,
      Map<String, dynamic> body) async {
    final response = await dio.patch(
      '/courts/$id',
      data: body,
    );

    return response.data['data'];
  }

  Future<void> deleteCourt(
      String id) async {
    await dio.delete('/courts/$id');
  }
}