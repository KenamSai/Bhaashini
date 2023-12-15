import 'package:bhaashini/model/translate_text_payload.dart';
import 'package:bhaashini/model/translate_text_response.dart';
import 'package:bhaashini/repository/translate_text_repository.dart';
import 'package:bhaashini/res/constants/apiConstants.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DashboardViewModel with ChangeNotifier {
  TranslateTextResponse? trnsresponse;
  String translatedText = "";
  TranslateText(BuildContext context, String text) async {
    TranslateTextRepository translateTextRepository = TranslateTextRepository();
    TranslateTextPayload payload = TranslateTextPayload(
      pipelineTasks: [
        PipelineTasks(
            config: Config(
                language: Language(sourceLanguage: "en", targetLanguage: "te"),
                serviceId: "ai4bharat/indictrans-v2-all-gpu--t4"),
            taskType: "translation"),
      ],
      inputData: InputData(input: [Input(source: text.trim())]),
    );
    Response<dynamic> response =
        await translateTextRepository.translateTextRepo(
      ApiConstants.NMT_END_URL,
      context,
      payload,
    );
    if (response.statusCode == 200) {
      trnsresponse =
          TranslateTextResponse.fromJson(response.data as Map<String, dynamic>);
      translatedText =
          trnsresponse?.pipelineResponse?[0].output?[0].target ?? "";

      notifyListeners();
    }
  }
}
