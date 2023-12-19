import 'package:bhaashini/res/routes/approutes.dart';
import 'package:bhaashini/view/Dashboard.dart';
import 'package:bhaashini/view/text_translation.dart';
import 'package:bhaashini/view/voice_translation.dart';
import 'package:flutter/material.dart';

class AppPages {
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.dashboard: (context) => Dashboard(),
      AppRoutes.textTranslation: (context) => TextTranslation(),
      AppRoutes.voiceTranslation: (context) => VoiceTranslation(),
    };
  }
}
