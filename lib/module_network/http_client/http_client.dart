import 'dart:convert';

import 'package:dio/dio.dart';



class ApiClient {
  String? token;
  final String tag = 'ApiClient';

  final _client = Dio(BaseOptions(

    baseUrl:'https://emergingideas.ae/test_apis/',
  ));


  Future<dynamic> get(
    String url, {
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {
      var response = await _client.get(
        url,
        queryParameters: queryParams,
      );
      return response.data;

    } catch (e) {
      return null;
    }
  }

  Future<dynamic> post(
    String url,
    Map<String, dynamic> payLoad, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {

    try {

    //_client.interceptors.add(performanceInterceptor);
      var response = await _client.post(url,
        queryParameters: queryParams,
        data: json.encode(payLoad)
      );
  return response.data;
    } catch (e) {
      return null;
    }
  }
  Future<dynamic> put(
    String url,
 {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {
     
      headers ??= {};
      _client.options.headers['Content-Type'] = 'application/json';

      var response = await _client.put(
        url,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );

      return response.data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> delete(
    String url, {
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {

      var response = await _client.delete(
        url,
        queryParameters: queryParams,
      );
      return response.data;
    } catch (e) {
      return null;
    }
  }


}
