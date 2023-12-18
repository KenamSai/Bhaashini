import 'package:bhaashini/model/NMT/nmt_translate_text_payload.dart';
import 'package:bhaashini/model/NMT/translate_text_response.dart';
import 'package:bhaashini/model/pipeline_payload.dart';
import 'package:bhaashini/model/pipeline_translation_response.dart';
import 'package:bhaashini/repository/pipeline_without_config_repo.dart';
import 'package:bhaashini/repository/translate_text_repository.dart';
import 'package:bhaashini/res/components/SingleButtonAlert.dart';
import 'package:bhaashini/res/constants/apiConstants.dart';
import 'package:bhaashini/res/constants/image_constants.dart';
import 'package:bhaashini/utils/internetcheck.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TextTranslationViewModel with ChangeNotifier {
  NMTTranslateTextResponse? trnsresponse;
  List<String?>? sourceLanguages = [];
  List<String?>? targetLanguages = [];
  String? selectedSourceLanguage;
  String? selectedTargetLanguage;
  PipeLineTranslationResponse? pipeLineResponse;
  bool isLoading = false;
  String translatedText = "";

  TranslateText(BuildContext context, String text) async {
    if (text.trim().isEmpty) {
      SingleButtonAlert.showAlertDialog(context,
          message: "Text cannot be empty", Title: "", onpressedOk: () {
        Navigator.pop(context);
      }, image: ImageConstants.error);
    } else if (selectedSourceLanguage == null) {
      SingleButtonAlert.showAlertDialog(context,
          message: "Please Select Source Language", Title: "", onpressedOk: () {
        Navigator.pop(context);
      }, image: ImageConstants.error);
    } else if (selectedTargetLanguage == null) {
      SingleButtonAlert.showAlertDialog(context,
          message: "Please Select Target Language", Title: "", onpressedOk: () {
        Navigator.pop(context);
      }, image: ImageConstants.error);
    } else {
      TranslateTextRepository translateTextRepository =
          TranslateTextRepository();
      NMTTranslateTextPayload payload = NMTTranslateTextPayload(
        pipelineTasks: [
          NMTPipelineTasks(
              config: NMTConfig(
                  language: NMTLanguage(
                      sourceLanguage: selectedSourceLanguage,
                      targetLanguage: selectedTargetLanguage),
                  serviceId: "ai4bharat/indictrans-v2-all-gpu--t4"),
              taskType: "translation"),
        ],
        inputData: NMTInputData(input: [
          NMTInput(
            source: text.trim(),
          )
        ]),
      );
      print("payload########################## ${payload.toJson()}");
      if (await internetCheck()) {
        setLoading(true);
        Response<dynamic>? response =
            await translateTextRepository.translateTextRepo(
          "${ApiConstants.NMT_BASE_URL}${ApiConstants.NMT_END_URL}",
          context,
          payload,
          setLoading
        );
        if (response?.statusCode == 200) {
          setLoading(false);
          trnsresponse = NMTTranslateTextResponse.fromJson(
              response?.data as Map<String, dynamic>);
          translatedText =
              trnsresponse?.pipelineResponse?[0].output?[0].target ?? "";

          notifyListeners();
        }
      } else {
        setLoading(false);
        SingleButtonAlert.showAlertDialog(context,
            message: "Please check your internet connection",
            Title: "", onpressedOk: () {
          Navigator.pop(context);
        }, image: ImageConstants.error);
      }
    }
  }

  clearData() {
    print("clear data");
    translatedText = "";
    selectedSourceLanguage = null;
    selectedTargetLanguage = null;
    sourceLanguages?.clear();
    targetLanguages?.clear();
    notifyListeners();
  }

  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  pipeLineData(BuildContext context) async {
    final pipelinePayLoad = PipeLinePayLoad(
      pipelineRequestConfig:
          PipelineRequestConfig(pipelineId: "64392f96daac500b55c543cd"),
      pipelineTasks: [PipelineTasks(taskType: "translation")],
    );
    if (await internetCheck()) {
      setLoading(true);
      Response<dynamic> response =
          await PipeLineRepository().PipeLineWithOutConfig(
        "${ApiConstants.BASE_URL}${ApiConstants.PIPELINE_END_URL}",
        context,
        pipelinePayLoad,
        setLoading
      );
      print("response ${response.statusCode}");
      if (response.statusCode == 200) {
        setLoading(false);
        print("response ${response.data}");
        pipeLineResponse = PipeLineTranslationResponse.fromJson(response.data);
        sourceLanguages = pipeLineResponse?.languages
            ?.map((json) => json.sourceLanguage)
            .toList();

        notifyListeners();
        setDefaultLanguage();
      } else {
        SingleButtonAlert.showAlertDialog(context,
            message: response.statusMessage ?? "", Title: "", onpressedOk: () {
          Navigator.pop(context);
        }, image: ImageConstants.error);
      }
    } else {
      SingleButtonAlert.showAlertDialog(context,
          message: "Please check your internet connection",
          Title: "", onpressedOk: () {
        Navigator.pop(context);
      }, image: ImageConstants.error);
    }
  }

  setSelectedSourceLanguage(String s) {
    selectedSourceLanguage = s;
    selectedTargetLanguage = null;
    getTargetLanguage();
  }

  getTargetLanguage() {
    targetLanguages = pipeLineResponse?.languages
        ?.where((element) => element.sourceLanguage == selectedSourceLanguage)
        .first
        .targetLanguageList;
    notifyListeners();
  }

  setSelectedTargetLanguage(String s) {
    selectedTargetLanguage = s;
    notifyListeners();
  }

  setDefaultLanguage() {
    selectedSourceLanguage = "en";
    targetLanguages = pipeLineResponse?.languages
        ?.where((element) => element.sourceLanguage == selectedSourceLanguage)
        .first
        .targetLanguageList;
    notifyListeners();
  }
}
