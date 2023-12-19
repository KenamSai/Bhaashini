import 'dart:convert';
import 'dart:io';
import 'package:bhaashini/model/ASR+NMT+TTS/voice_translation_payload.dart';
import 'package:bhaashini/model/ASR+NMT+TTS/voice_translation_response.dart';
import 'package:bhaashini/model/NMT/nmt_translate_text_payload.dart';
import 'package:bhaashini/model/PipeLineWithOutConfig/pipeline_payload.dart';
import 'package:bhaashini/model/PipeLineWithOutConfig/pipeline_translation_response.dart';
import 'package:bhaashini/repository/pipeline_without_config_repo.dart';
import 'package:bhaashini/repository/translate_text_repository.dart';
import 'package:bhaashini/repository/translate_voice_repository.dart';
import 'package:bhaashini/res/components/SingleButtonAlert.dart';
import 'package:bhaashini/res/constants/apiConstants.dart';
import 'package:bhaashini/res/constants/image_constants.dart';
import 'package:bhaashini/utils/internetcheck.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class VoiceTranslationViewModel with ChangeNotifier {
  VoiceTranslationResponse? voiceResponse;
  bool isRecording = false;
  List<String?>? sourceLanguages = [];
  List<String?>? targetLanguages = [];
  String? selectedSourceLanguage;
  String? selectedTargetLanguage;
  String _fileName = 'Bhaashini.wav';
  Directory? appDocDir;
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
                setLoading);
        if (response?.statusCode == 200) {
          setLoading(false);
          voiceResponse = VoiceTranslationResponse.fromJson(
              response?.data as Map<String, dynamic>);
          // translatedText =
          //     trnsresponse?.pipelineResponse?[0].output?[0].target ?? "";

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

    selectedSourceLanguage = null;
    selectedTargetLanguage = null;
    sourceLanguages?.clear();
    targetLanguages?.clear();
    isRecording = false;
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
      pipelineTasks: [
        PipelineTasks(taskType: "asr"),
        PipelineTasks(taskType: "translation"),
        PipelineTasks(taskType: "tts"),
      ],
    );
    if (await internetCheck()) {
      setLoading(true);
      Response<dynamic> response = await PipeLineRepository()
          .PipeLineWithOutConfig(
              "${ApiConstants.BASE_URL}${ApiConstants.PIPELINE_END_URL}",
              context,
              pipelinePayLoad,
              setLoading);
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

  AudioRecorder record = AudioRecorder();
  onMicTap(BuildContext context) async {
    recordingStatus();
    if (selectedSourceLanguage == null || selectedTargetLanguage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select source and target language"),
        ),
      );
    } else {
      PermissionStatus status = await Permission.storage.request();
      if (status.isGranted) {
        if (Platform.isAndroid) {
          appDocDir = Directory('/storage/emulated/0/Download/');
        } else {
          appDocDir = await getApplicationDocumentsDirectory();
        }

        Directory directory = Directory('${appDocDir?.path}record');

        print("appDocDir@@@@@@@@@ ${directory.path}");
        if (!(await directory.exists())) {
          await directory.create(recursive: true);
        } else {
          print("Directory already exists");
        }

        // Check and request permission if needed
        if (await record.hasPermission()) {
          print(
              "hello ************* ${directory.path} isRecording $isRecording");
          // Start recording to file
          if (isRecording) {
            await record.start(const RecordConfig(encoder: AudioEncoder.wav),
                path: '${directory.path}/$_fileName');
          } else {
            stopRecording(context);
          }
        } else {
          await Permission.microphone.request();
        }
      } else {
        // Handle the case when the user denies permission.
        print("Permission denied@@@");
      }
    }
  }

  recordingStatus() async {
    if (isRecording) {
      isRecording = false;
      notifyListeners();
    } else {
      isRecording = true;
      notifyListeners();
    }
  }

  stopRecording(BuildContext context) async {
    print("recording stopped");
    final path = await record.stop();
    print("path^^^^^^^^^^^^^^^ ${path}");
    // Check if the file exists
    if (File(path ?? "").existsSync()) {
      print('File permissions: ${await File(path ?? "").stat()}');
      String? base64 = await convertAudioToBase64('$path');
      notifyListeners();
      await TranslateSpeech(context, base64 ?? "");
      // Read the file
      // ...
    } else {
      print('File does not exist at the specified path');
    }
  }

  Future<String?> convertAudioToBase64(String filePath) async {
    try {
      print("filePath $filePath");
      // Read audio file as bytes
      List<int> bytes = await File(filePath).readAsBytes();

      // Encode bytes to Base64
      String base64String = base64Encode(bytes);
      debugPrint("base64String $base64String");
      return base64String;
    } catch (e) {
      print('Error converting audio to Base64: $e');
      return null;
    }
  }

  TranslateSpeech(BuildContext context, String base64) async {
    TranslateVoiceRepository translateVoiceRepository =
        TranslateVoiceRepository();
    VoiceTranslationPayload payload = VoiceTranslationPayload(
      pipelineTasks: [
        VoicePipelineTasks(
          taskType: "asr",
          config: VoiceConfig(
              language:
                  VoiceLanguage(sourceLanguage: "$selectedSourceLanguage"),
              serviceId: "ai4bharat/whisper-medium-en--gpu--t4",
              samplingRate: 16000,
              audioFormat: "WAV"),
        ),
        VoicePipelineTasks(
          taskType: "translation",
          config: VoiceConfig(
              language: VoiceLanguage(
                  sourceLanguage: "$selectedSourceLanguage",
                  targetLanguage: "$selectedTargetLanguage"),
              serviceId: "ai4bharat/indictrans-v2-all-gpu--t4"),
        ),
        VoicePipelineTasks(
          taskType: "tts",
          config: VoiceConfig(
              language:
                  VoiceLanguage(sourceLanguage: "$selectedTargetLanguage"),
              serviceId: "ai4bharat/indic-tts-coqui-dravidian-gpu--t4",
              gender: "male",
              samplingRate: 8000),
        ),
      ],
      inputData: InputData(
        audio: [
          Audio(audioContent: base64),
        ],
      ),
    );
    print("payload########################## ${payload.toJson()}");
    if (await internetCheck()) {
      setLoading(true);
      Response<dynamic>? response =
          await translateVoiceRepository.translateVoiceRepo(
              "${ApiConstants.NMT_BASE_URL}${ApiConstants.NMT_END_URL}",
              context,
              payload,
              setLoading);
      if (response?.statusCode == 200) {
        setLoading(false);
        voiceResponse = VoiceTranslationResponse.fromJson(
            response?.data as Map<String, dynamic>);
        translatedText =
            voiceResponse?.pipelineResponse?[0].output?[0].target ?? "";

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
