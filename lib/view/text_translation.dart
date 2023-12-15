import 'package:bhaashini/res/constants/color_constants.dart';
import 'package:bhaashini/res/constants/image_constants.dart';
import 'package:flutter/material.dart';

class TextTranslation extends StatefulWidget {
  const TextTranslation({super.key});

  @override
  State<TextTranslation> createState() => _TextTranslationState();
}

class _TextTranslationState extends State<TextTranslation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorConstants.appColor,
        title: const Text(
          'Text',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage(ImageConstants.bg), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        height: 50.0, // Adjust the height as needed
                        child: Center(
                          child: Text(
                            'Telugu',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0), // Add spacing between widgets
                    Expanded(
                      child: SizedBox(
                        child: GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            ImageConstants.translate_arrow,
                            color: Colors.white,
                          ),
                        ),
                        height: 50,
                      ),
                    ),
                    SizedBox(width: 8.0), // Add spacing between widgets
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        height: 50.0, // Adjust the height as needed
                        child: Center(
                          child: Text(
                            'Hindi',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.green,
                      width: 1,
                    ),
                  ),
                  child: Text("data"),
                ),
                Card()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
