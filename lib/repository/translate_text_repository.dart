import 'package:bhaashini/data/base_api_client.dart';
import 'package:bhaashini/model/NMT/nmt_translate_text_payload.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TranslateTextRepository {
  final _baseClient = BaseApiClient();
  Future<Response<dynamic>?> translateTextRepo(String url, BuildContext context,
      NMTTranslateTextPayload payload, Function(bool value) setLoading) async {
    final response = await _baseClient.postCall(
        context,
        url,
        payload.toJson(),
        {
          "Authorization":
              "fRC3IepTDktqNBREnwcvCCNzs1AakAaQHjbDFkE7SUX3MizaCE0RbIDPPXCeELHK"
        },
        setLoading);

    return response;
  }
}
