import 'package:clubhub/constants/app_theme.dart';
import 'package:clubhub/constants/bottom_page.dart';
import 'package:clubhub/constants/size_config.dart';
import 'package:clubhub/features/auth/services/auth_service.dart';
import 'package:clubhub/features/club_manager/screens/application_screen.dart';
import 'package:clubhub/features/club_manager/screens/club_manager_bottom_bar.dart';
import 'package:clubhub/features/onboarding/screens/onboarding.dart';
import 'package:clubhub/providers/user_provider.dart';
import 'package:clubhub/router.dart';
import 'package:clubhub/features/super_admin/screens/super_admin_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ClubHub',
      theme: AppTheme.themeData,
      onGenerateRoute: (settings) => generateRoute(settings),
      home: _getHomeScreen(),
    );
  }

  Widget _getHomeScreen() {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        if (userProvider.user.token.isNotEmpty) {
          if (userProvider.user.type == 'user') {
            return BottomBar();
          } else if (userProvider.user.type == 'club-manager') {
            return ClubManagerBottomBar(clubId:  userProvider.user.clubOwned );
          } else {
            return SuperAdminBottomBar();
          }
        } else {
          return const OnBoardingScreen();
        }
      },
    );
  }
}
