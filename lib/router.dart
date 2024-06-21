import 'package:clubhub/commons/widgets/clubs_details_screen.dart';
import 'package:clubhub/constants/bottom_page.dart';
import 'package:clubhub/features/auth/screens/login_screen.dart';
import 'package:clubhub/features/auth/screens/create_account_screen.dart';
import 'package:clubhub/features/club_manager/screens/club_manager_bottom_bar.dart';
import 'package:clubhub/features/club_manager/screens/application_screen.dart';
import 'package:clubhub/features/club_manager/screens/notification.dart';
import 'package:clubhub/features/profile/screens/profile_screen.dart';
import 'package:clubhub/features/super_admin/screens/super_admin_bottom_bar.dart';
import 'package:clubhub/models/club.dart';
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
    case SuperAdminBottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SuperAdminBottomBar());
  
            case ClubDetailScreen.routeName:
             var club = routeSettings.arguments as Club;
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) =>  ClubDetailScreen(club:  club,));
           case ClubManagerBottomBar.routeName:
           var clubId=routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) =>  ClubManagerBottomBar(clubId: clubId ,));
            case ClubManagerApplicationsScreen.routeName:
             var clubId = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) =>  ClubManagerApplicationsScreen(clubId:clubId ,));
           case ClubManagerNotificationScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) =>  ClubManagerNotificationScreen());
          
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
