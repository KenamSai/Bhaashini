import 'package:bhaashini/res/components/appbar_reusable.dart';
import 'package:bhaashini/res/components/loader.dart';
import 'package:bhaashini/res/constants/color_constants.dart';
import 'package:bhaashini/res/constants/image_constants.dart';
import 'package:bhaashini/res/routes/approutes.dart';
import 'package:bhaashini/viewModel/voice_translation_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class VoiceTranslation extends StatefulWidget {
  const VoiceTranslation({super.key});

  @override
  State<VoiceTranslation> createState() => _VoiceTranslationState();
}

class _VoiceTranslationState extends State<VoiceTranslation> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final voiceProvider = Provider.of<VoiceTranslationViewModel>(context);
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        voiceProvider.clearData();
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBarReusable(
              title: "Voice Translation",
              onPressedBack: () {
                Navigator.pop(context);
                voiceProvider.clearData();
              },
              onpressedHome: () {
                voiceProvider.clearData();
                Navigator.pushNamed(context, AppRoutes.dashboard);
              },
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExactAssetImage(ImageConstants.bg),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'Source Language',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  color: ColorConstants.appColor,
                                  height: 40.0,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5.0),
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          dropdownColor:
                                              ColorConstants.appColor,
                                          value: voiceProvider
                                              .selectedSourceLanguage,
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          iconSize: 24,
                                          elevation: 16,
                                          iconEnabledColor: Colors.white,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          onChanged: (String? newValue) {
                                            voiceProvider
                                                .setSelectedSourceLanguage(
                                                    newValue ?? '');
                                          },
                                          items: voiceProvider.sourceLanguages
                                                  ?.where(
                                                      (value) => value != null)
                                                  .map<
                                                      DropdownMenuItem<String>>(
                                                (String? value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value ??
                                                        '', // Use an empty string as a default if value is null
                                                    child: Text(
                                                      value ??
                                                          '', // Use an empty string as a default if value is null
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  );
                                                },
                                              ).toList() ??
                                              [],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: SizedBox(
                              child: GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  ImageConstants.translate_arrow,
                                  color: Colors.white,
                                ),
                              ),
                              height: 40,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'Target Language',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  color: ColorConstants.appColor,
                                  height: 40.0,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        hintText: "translate",
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5.0),
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          dropdownColor:
                                              ColorConstants.appColor,
                                          value: voiceProvider
                                              .selectedTargetLanguage,
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          iconSize: 24,
                                          elevation: 16,
                                          iconEnabledColor: Colors.white,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          onChanged: (String? newValue) {
                                            voiceProvider
                                                .setSelectedTargetLanguage(
                                                    newValue ?? '');
                                          },
                                          items: voiceProvider.targetLanguages
                                                  ?.where(
                                                      (value) => value != null)
                                                  .map<
                                                      DropdownMenuItem<String>>(
                                                (String? value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value ??
                                                        '', // Use an empty string as a default if value is null
                                                    child: Text(
                                                      value ??
                                                          '', // Use an empty string as a default if value is null
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  );
                                                },
                                              ).toList() ??
                                              [],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SingleChildScrollView(
                                        child: Text(
                                          voiceProvider.sourceText,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          height: MediaQuery.of(context).size.height * 0.32,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.32,
                        width: double.infinity,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.green.shade400,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: Text(
                                      voiceProvider.translatedText,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed:
                                        voiceProvider.translatedText == ""
                                            ? null
                                            : () {
                                                Clipboard.setData(
                                                  new ClipboardData(
                                                      text: voiceProvider
                                                          .translatedText),
                                                ).then((value) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          'Copied to your clipboard !'),
                                                    ),
                                                  );
                                                });
                                              },
                                    icon: Icon(
                                      Icons.copy,
                                      color: voiceProvider.translatedText == ""
                                          ? Colors.grey
                                          : Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        voiceProvider.playAudio(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.orange.shade800,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.volume_up_outlined),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            voiceProvider.onMicTap(context);
                          },
                          // onLongPress: () {
                          //   voiceProvider.onMicLongPress(context);
                          // },
                          // onLongPressEnd: (details) {
                          //   voiceProvider.stopRecording(context);
                          // },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.orange.shade800,
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.mic,
                                    color: Colors.black,
                                    size: 40,
                                  ),
                                ),
                                if (voiceProvider.isRecording)
                                  Lottie.asset('assets/mic.json',
                                      height: 60, width: 60),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (voiceProvider.isLoading) LoaderComponent()
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final voiceProvider =
          Provider.of<VoiceTranslationViewModel>(context, listen: false);
      voiceProvider.pipeLineData(context);
    });
  }
}
