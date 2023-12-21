import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:bhaashini/model/ASR+NMT+TTS/voice_translation_payload.dart';
import 'package:bhaashini/model/ASR+NMT+TTS/voice_translation_response.dart';
import 'package:bhaashini/model/PipeLineWithOutConfig/pipeline_payload.dart';
import 'package:bhaashini/model/PipeLineWithOutConfig/pipeline_translation_response.dart';
import 'package:bhaashini/repository/pipeline_without_config_repo.dart';
import 'package:bhaashini/repository/translate_voice_repository.dart';
import 'package:bhaashini/res/components/SingleButtonAlert.dart';
import 'package:bhaashini/res/constants/apiConstants.dart';
import 'package:bhaashini/res/constants/image_constants.dart';
import 'package:bhaashini/utils/internetcheck.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
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
  String sourceText = "";
  List<int>? byteList;
  String? asrServiceId;
  String? nmtServiceId;
  String? ttsServiceId;

  clearData() {
    print("clear data");
    selectedSourceLanguage = null;
    selectedTargetLanguage = null;
    sourceLanguages?.clear();
    targetLanguages?.clear();
    sourceText = "";
    translatedText = "";
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
    notifyListeners();
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
    getServicId();
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
    //placed here to avoid multiple clicks*
    // recordingStatus();
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

        // print("appDocDir@@@@@@@@@ ${directory.path}");
        if (!(await directory.exists())) {
          await directory.create(recursive: true);
        } else {
          print("Directory already exists");
        }

        // Check and request permission if needed
        if (await record.hasPermission()) {
          recordingStatus();
          print("hello ************* isRecording $isRecording");
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
    } else {
      isRecording = true;
    }
    notifyListeners();
  }

  stopRecording(BuildContext context) async {
    print("recording stopped");
    final path = await record.stop();
    notifyListeners();
    print("path^^^^^^^^^^^^^^^ ${path}");
    // Check if the file exists
    if (File(path ?? "").existsSync()) {
      print('File permissions: ${await File(path ?? "").stat()}');
      String? base64 = await convertAudioToBase64('$path');
      await TranslateSpeech(context, base64 ?? "");
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
      debugPrint("base64String $base64String   @@");
      return base64String;
    } catch (e) {
      print('Error converting audio to Base64: $e');
      return null;
    }
  }

  TranslateSpeech(BuildContext context, String base64) async {
    print(
        "asr@@@@ $asrServiceId    nmt@@@@ $nmtServiceId   tts@@@@ $ttsServiceId");
    TranslateVoiceRepository translateVoiceRepository =
        TranslateVoiceRepository();
    VoiceTranslationPayload payload = VoiceTranslationPayload(
      pipelineTasks: [
        VoicePipelineTasks(
          taskType: "asr",
          config: VoiceConfig(
              language:
                  VoiceLanguage(sourceLanguage: "$selectedSourceLanguage"),
              serviceId: "$asrServiceId",
              samplingRate: 16000,
              audioFormat: "wav"),
        ),
        VoicePipelineTasks(
          taskType: "translation",
          config: VoiceConfig(
              language: VoiceLanguage(
                  sourceLanguage: "$selectedSourceLanguage",
                  targetLanguage: "$selectedTargetLanguage"),
              serviceId: "$nmtServiceId"),
        ),
        VoicePipelineTasks(
          taskType: "tts",
          config: VoiceConfig(
              language:
                  VoiceLanguage(sourceLanguage: "$selectedTargetLanguage"),
              serviceId: "$ttsServiceId",
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
        print("response%%%%%%%%%%%%%%%%% ${response}");
        setLoading(false);
        voiceResponse = VoiceTranslationResponse.fromJson(
            response?.data as Map<String, dynamic>);
        print("voiceResponse ${voiceResponse?.toJson()}");
        sourceText =
            voiceResponse?.pipelineResponse?[0].output?[0].source ?? "";
        translatedText =
            voiceResponse?.pipelineResponse?[1].output?[0].target ?? "";
        String translatedTextBase64 =
            voiceResponse?.pipelineResponse?[2].audio?[0].audioContent ?? "";
        Uint8List voiceBytes = base64Decode(translatedTextBase64);
        print("voiceBytes####################### $voiceBytes");
        // Convert Uint8List to List<int>
        byteList = voiceBytes;

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

  playAudio(BuildContext context) async {
    final player = AudioPlayer();
    try {
      print("byteList $byteList");
      await player.setAudioSource(
        MyCustomSource(byteList ?? []),
      );
    } catch (e) {
      print('Error setting audio source: $e');
    }

    await player.play();
  }

  getServicId() {
    print("@@@@@@@@@@@@@@@@@@@@@@@");
    if (pipeLineResponse?.pipelineResponseConfig?[0].taskType == "asr") {
      asrServiceId = pipeLineResponse?.pipelineResponseConfig?[0].config
          ?.firstWhere((element) =>
              element.language?.sourceLanguage == selectedSourceLanguage)
          .serviceId;
    }
    if (pipeLineResponse?.pipelineResponseConfig?[1].taskType ==
        "translation") {
      nmtServiceId = pipeLineResponse?.pipelineResponseConfig?[1].config
          ?.firstWhere((element) =>
              element.language?.sourceLanguage == selectedSourceLanguage)
          .serviceId;
    }
    if (pipeLineResponse?.pipelineResponseConfig?[2].taskType == "tts") {
      ttsServiceId = pipeLineResponse?.pipelineResponseConfig?[2].config
          ?.firstWhere((element) =>
              element.language?.sourceLanguage == selectedTargetLanguage)
          .serviceId;
    }
    notifyListeners();
  }
}

// Feed your own stream of bytes into the player
class MyCustomSource extends StreamAudioSource {
  final List<int> bytes;
  MyCustomSource(this.bytes);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    print("@@@@@@@@@@@@@@$bytes");
    start ??= 0;
    end ??= bytes.length;
    // Create a StreamController to provide the audio data
    final controller = StreamController<List<int>>();

    // Add the sublist of bytes to the stream
    controller.add(bytes.sublist(start, end));

    // Close the stream after the data has been provided
    controller.close();
    return StreamAudioResponse(
      sourceLength: bytes.length,
      contentLength: end - start,
      offset: start,
      stream: controller.stream,
      contentType: 'audio/wav',
    );
  }
}
