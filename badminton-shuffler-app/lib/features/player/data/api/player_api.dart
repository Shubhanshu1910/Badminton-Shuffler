import 'package:dio/dio.dart';

import '../../../../core/api/api_client.dart';

class PlayerApi {
  final Dio dio = ApiClient.dio;

  Future<List<dynamic>> getPlayers() async {
  final response = await dio.get('/players');

  print(response.data);

  return response.data['data']['items'];
}

  Future<Map<String, dynamic>> createPlayer(
    Map<String, dynamic> body,
  ) async {
    final Response response = await ApiClient.dio.post(
      '/players',
      data: body,
    );

    return response.data['data'];
  }

  Future<void> deletePlayer(String id) async {
    await ApiClient.dio.delete('/players/$id');
  }

  Future<Map<String, dynamic>> updatePlayer(
    String id,
    Map<String, dynamic> body,
  ) async {
    final Response response = await ApiClient.dio.patch(
      '/players/$id',
      data: body,
    );

    return response.data['data'];
  }
}