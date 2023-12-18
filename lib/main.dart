import 'package:bhaashini/res/routes/apppages.dart';
import 'package:bhaashini/viewModel/dashboard_view_model.dart';
import 'package:bhaashini/viewModel/text_translation_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'res/routes/approutes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DashboardViewModel(),
        ),
         ChangeNotifierProvider(
          create: (context) => TextTranslationViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: AppRoutes.initial,
        routes: AppPages.routes,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
