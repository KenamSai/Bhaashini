import 'dart:convert';
import 'dart:io';
import 'package:bhaashini/res/components/SingleButtonAlert.dart';
import 'package:bhaashini/res/constants/image_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ErrorHandlingUtils {
  static String handleError(dynamic e, BuildContext context) {
    String msg = "";
    if (e is DioException) {
      if (e.response?.statusCode == 401) {
        final responseBody = e.response?.data;
        if (responseBody != null) {
          final jsonData = json.encode(responseBody);
          msg = getErrorMessage(jsonData);
        }
      } else if (e.response?.statusCode == 500) {
        msg = "Error:response not received";
      } else if (e.type == DioExceptionType.connectionTimeout) {
        msg = "Connection timed out";
      } else if (e.type == DioExceptionType.receiveTimeout) {
        msg = "Receive timeout occurred.";
      } else {
        msg = "Server not responding: ${e.response?.statusMessage}";
      }
    } else if (e is SocketException) {
      msg = "Something went wrong: ${e.message}";
    } else {
      msg = "Something went wrong: ${e.toString()}";
    }
    return msg;
  }

  static String getErrorMessage(String jsonData) {
    try {
      final parsedJson = json.decode(jsonData);
      return parsedJson['error']['message'];
    } catch (e) {
      return "Something went wrong, Please try again later";
    }
  }

  showErrorDialog(BuildContext context, String errorMessage) {
    return SingleButtonAlert.showAlertDialog(
      context,
      message: errorMessage,
      Title: "",
      onpressedOk: () {
        Navigator.pop(context);
      },
      image: ImageConstants.error,
    );
  }
}
