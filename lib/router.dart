import 'package:clubhub/constants/bottom_page.dart';
import 'package:clubhub/features/auth/screens/login_screen.dart';
import 'package:clubhub/features/auth/screens/create_account_screen.dart';
import 'package:clubhub/features/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import 'features/settings/screen/setting_screen.dart';


Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
   case CreateAccountScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const CreateAccountScreen());
    case LoginScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const LoginScreen());
case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomBar());
   case SettingsScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SettingsScreen());
   case HelpSupportScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HelpSupportScreen());
   
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Screen does not exist'),
                ),
              ));
  }
}
