import 'package:bhaashini/data/base_api_client.dart';
import 'package:bhaashini/model/ASR+NMT+TTS/voice_translation_payload.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TranslateVoiceRepository {
  final _baseClient = BaseApiClient();
  Future<Response<dynamic>?> translateVoiceRepo(
      String url,
      BuildContext context,
      VoiceTranslationPayload payload,
      Function(bool value) setLoading) async {
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
