import 'package:clubhub/commons/widgets/clubs_details_screen.dart';
import 'package:clubhub/constants/bottom_page.dart';
import 'package:clubhub/features/auth/screens/login_screen.dart';
import 'package:clubhub/features/auth/screens/create_account_screen.dart';
import 'package:clubhub/features/club_manager/screens/club_manager_bottom_bar.dart';
import 'package:clubhub/features/club_manager/screens/application_screen.dart';
import 'package:clubhub/features/club_manager/screens/create_team_details.dart';
import 'package:clubhub/features/club_manager/screens/notification.dart';
import 'package:clubhub/features/club_manager/screens/workspace.dart';
import 'package:clubhub/features/explore/screens/application_screen.dart';
import 'package:clubhub/features/home_users/screens/home_screen.dart';
import 'package:clubhub/features/home_users/screens/workspace_members.dart';
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
          settings: routeSettings,
          builder: (_) => ClubDetailScreen(
                club: club,
              ));
    case ClubManagerBottomBar.routeName:
      var clubId = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ClubManagerBottomBar(
                clubId: clubId,
              ));
    case ClubManagerApplicationsScreen.routeName:
      var clubId = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ClubManagerApplicationsScreen(
                clubId: clubId,
              ));
    case ClubManagerNotificationScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ClubManagerNotificationScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());
    case ApplicationScreen.routeName:
      var club = routeSettings.arguments as Club;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ApplicationScreen(
                club: club,
              ));
    case WorkSpaceClubManager.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const WorkSpaceClubManager());
    case CreateTeamDetails.routeName:
    final args = routeSettings.arguments as Map<String, dynamic>;
    final selectedUserIds = args['selectedUserIds'] as List<String>;
    final clubId = args['clubId'] as String;

      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CreateTeamDetails(
                clubId: clubId,
                selectedUserIds: selectedUserIds,
              ));
               case WorkSpaceMembers.routeName:
               var clubId=routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => WorkSpaceMembers(clubId:  clubId,));
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
