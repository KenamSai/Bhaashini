import 'package:bhaashini/data/base_api_client.dart';
import 'package:bhaashini/model/pipeline_with_config_payload.dart';
import 'package:bhaashini/model/pipeline_with_config_response.dart';
import 'package:flutter/material.dart';

class DashboardRepository {
  final _baseClient = BaseApiClient();
  Future<PipeLineWithConfigResponse> getDashboardInfo(String url,
      BuildContext context, PipeLineWithConfigPayLoad payload) async {
    final response = await _baseClient.postCall(context, url, payload.toJson());

    return PipeLineWithConfigResponse.fromJson(response);
  }
}
