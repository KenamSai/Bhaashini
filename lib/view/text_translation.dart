import 'package:bhaashini/res/components/appbar_reusable.dart';
import 'package:bhaashini/res/components/loader.dart';
import 'package:bhaashini/res/constants/color_constants.dart';
import 'package:bhaashini/res/constants/image_constants.dart';
import 'package:bhaashini/res/routes/approutes.dart';
import 'package:bhaashini/viewModel/text_translation_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TextTranslation extends StatefulWidget {
  const TextTranslation({super.key});

  @override
  State<TextTranslation> createState() => _TextTranslationState();
}

class _TextTranslationState extends State<TextTranslation> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final textProvider = Provider.of<TextTranslationViewModel>(context);
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        textProvider.clearData();
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBarReusable(
              title: "Text Translation",
              onPressedBack: () {
                Navigator.pop(context);
                textProvider.clearData();
              },
              onpressedHome: () {
                textProvider.clearData();
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
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5.0),
                                        labelStyle: TextStyle(color: Colors.white),
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          dropdownColor: ColorConstants.appColor,
                                          value:
                                              textProvider.selectedSourceLanguage,
                                          icon: const Icon(Icons.arrow_drop_down),
                                          iconSize: 24,
                                          elevation: 16,
                                          iconEnabledColor: Colors.white,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          onChanged: (String? newValue) {
                                            textProvider.setSelectedSourceLanguage(
                                                newValue ?? '');
                                          },
                                          items: textProvider.sourceLanguages
                                                  ?.where((value) => value != null)
                                                  .map<DropdownMenuItem<String>>(
                                                (String? value) {
                                                  return DropdownMenuItem<String>(
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
                              children: [  Padding(
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
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                      hintText: "translate",
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5.0),
                                        labelStyle: TextStyle(color: Colors.white),
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          dropdownColor: ColorConstants.appColor,
                                          value:
                                              textProvider.selectedTargetLanguage,
                                          icon: const Icon(Icons.arrow_drop_down),
                                          iconSize: 24,
                                          elevation: 16,
                                          iconEnabledColor: Colors.white,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          onChanged: (String? newValue) {
                                            textProvider.setSelectedTargetLanguage(
                                                newValue ?? '');
                                          },
                                          items: textProvider.targetLanguages
                                                  ?.where((value) => value != null)
                                                  .map<DropdownMenuItem<String>>(
                                                (String? value) {
                                                  return DropdownMenuItem<String>(
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      textInputAction: TextInputAction.done,
                                      controller: textEditingController,
                                      style: TextStyle(fontSize: 20),
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your text here',
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Colors.green,
                                        ),
                                      ),
                                      onPressed: () {
                                        FocusScope.of(context).unfocus();
                                        textProvider.TranslateText(context,
                                            textEditingController.text);
                                      },
                                      child: Text(
                                        'Translate',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
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
                                        textProvider.translatedText,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: IconButton(
                                    onPressed: textProvider.translatedText == ""
                                        ? null
                                        : () {
                                            Clipboard.setData(
                                              new ClipboardData(
                                                  text: textProvider
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
                                      color: textProvider.translatedText == ""
                                          ? Colors.grey
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (textProvider.isLoading) LoaderComponent()
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final textProvider =
          Provider.of<TextTranslationViewModel>(context, listen: false);
      textProvider.pipeLineData(context);
    });
  }
}
