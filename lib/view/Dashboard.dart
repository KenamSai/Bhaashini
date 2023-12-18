import 'package:bhaashini/res/constants/color_constants.dart';
import 'package:bhaashini/res/constants/image_constants.dart';
import 'package:bhaashini/res/routes/approutes.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController sourceTextController = TextEditingController();
  // String selectedValue = 'English';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorConstants.appColor,
        title: const Text(
          'Bhaashini',
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.textTranslation);
                        },
                        child: SizedBox(
                          height: 170,
                          child: Card(
                            elevation: 4.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ImageConstants
                                      .text, // Replace with your image URL
                                  height: 100,
                                  // Adjust the height as needed
                                  width: 100, // Take full width
                                  fit: BoxFit.cover, // Adjust the fit as needed
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 4.0),
                                  child: Text(
                                    'Text',
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )

                      //  Card(
                      //   elevation: 4.0,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(16.0),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         // DropdownButton<String>(
                      //         //   value: selectedValue,
                      //         //   onChanged: (newValue) {
                      //         //     setState(() {
                      //         //       selectedValue = newValue!;
                      //         //     });
                      //         //   },
                      //         //   items: [
                      //         //     'English',
                      //         //     'Telugu',
                      //         //     'Hindi',
                      //         //   ]
                      //         //       .map<DropdownMenuItem<String>>(
                      //         //         (String value) => DropdownMenuItem<String>(
                      //         //           value: value,
                      //         //           child: Text(value),
                      //         //         ),
                      //         //       )
                      //         //       .toList(),
                      //         // ),
                      //         SizedBox(height: 16.0),
                      //         TextField(
                      //           controller: sourceTextController,
                      //           decoration: InputDecoration(
                      //             labelText: 'Enter Text',
                      //             border: OutlineInputBorder(),
                      //           ),
                      //         ),
                      //         SizedBox(height: 10.0),
                      //         ElevatedButton(
                      //           onPressed: () {
                      //             dashboardProvider.TranslateText(
                      //                 context, sourceTextController.text);
                      //           },
                      //           child: Text("Translate"),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      ),
                  SizedBox(width: 16.0),
                  Expanded(
                      child: SizedBox(
                    height: 170,
                    child: Card(
                      elevation: 4.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageConstants.voice, // Replace with your image URL
                            height: 100,
                            // Adjust the height as needed
                            width: 100, // Take full width
                            fit: BoxFit.cover, // Adjust the fit as needed
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 4.0),
                            child: Text(
                              'Voice',
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )

                      // Card(
                      //   elevation: 4.0,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(16.0),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         // DropdownButton<String>(
                      //         //   value: selectedValue,
                      //         //   onChanged: (newValue) {
                      //         //     setState(() {
                      //         //       selectedValue = newValue!;
                      //         //     });
                      //         //   },
                      //         //   items: [
                      //         //     'Option 1',
                      //         //     'Option 2',
                      //         //     'Option 3',
                      //         //     'Option 4'
                      //         //   ]
                      //         //       .map<DropdownMenuItem<String>>(
                      //         //         (String value) => DropdownMenuItem<String>(
                      //         //           value: value,
                      //         //           child: Text(value),
                      //         //         ),
                      //         //       )
                      //         //       .toList(),
                      //         // ),
                      //         SizedBox(height: 16.0),
                      //         Text("${dashboardProvider.translatedText}")
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
