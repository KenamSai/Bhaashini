import 'package:bhaashini/res/constants/color_constants.dart';
import 'package:flutter/material.dart';

class SingleButtonAlert {
  static showAlertDialog(BuildContext context,
      {required String message,
      required String Title,
      required Function()? onpressedOk,
      String? versiontext,
      required String image,
      Color? buttonColor}) {
    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return await Future.value(false);
          },
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  padding:
                      EdgeInsets.only(left: 10, top: 35, right: 10, bottom: 10),
                  margin: EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(0, 10),
                            blurRadius: 10),
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (versiontext != null)
                        Text(
                          "Version: $versiontext",
                          textAlign: TextAlign.center,
                        ),
                      if (versiontext != null)
                        SizedBox(
                          height: 5,
                        ),
                      Text(
                        Title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.appColor),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        message,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.05,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: buttonColor ?? Colors.red,
                        ),
                        child: TextButton(
                          onPressed: onpressedOk,
                          child: Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        child: Container(
                          child: Image.asset(image),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
