import 'package:bhaashini/data/base_api_client.dart';
import 'package:bhaashini/model/translate_text_payload.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TranslateTextRepository {
  final _baseClient = BaseApiClient();
  Future<Response<dynamic>> translateTextRepo(
      String url, BuildContext context, TranslateTextPayload payload) async {
    final response = await _baseClient.postCall(context, url, payload.toJson());

    return response;
  }
}
