import 'package:bhaashini/data/base_api_client.dart';
import 'package:bhaashini/model/pipeline_payload.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PipeLineRepository {
  final _baseClient = BaseApiClient();
  Future<Response<dynamic>> PipeLineWithOutConfig(
      String url,
      BuildContext context,
      PipeLinePayLoad payload,
      Function(bool value) setLoading) async {
    final response = await _baseClient.postCall(
        context,
        url,
        payload.toJson(),
        {
          "userID": "baabdc2498de43f2ade21848f1f1c10c",
          "ulcaApiKey": "52d4f5ed56-2e2a-43ef-b00d-6c0ff2ff6085"
        },
        setLoading);

    return response;
  }
}
