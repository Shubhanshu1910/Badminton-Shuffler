import 'package:dio/dio.dart';
import '../../../core/api/api_client.dart';

class SessionApi {
  final Dio dio = ApiClient.dio;

  Future<List<dynamic>> getSessions() async {
    final response = await dio.get('/sessions');

    return response.data['data'];
  }
}