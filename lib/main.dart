
import 'package:clubhub/constants/app_theme.dart';
import 'package:clubhub/constants/size_config.dart';
import 'package:clubhub/features/onboarding/screens/onboarding.dart';
import 'package:clubhub/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ClubHub',
      theme: AppTheme.themeData,
      home:  OnBoardingScreen(),
      onGenerateRoute: (settings) => generateRoute(settings)
    );
  }
}

