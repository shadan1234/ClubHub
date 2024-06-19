
import 'package:clubhub/constants/colors.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = '/settings';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: AppColors.primary,
      ),
      body: Center(
        child: Text(
          'Settings Screen - Coming Soon!',
          style: TextStyle(fontSize: 18, color: AppColors.primaryText),
        ),
      ),
    );
  }
}

class HelpSupportScreen extends StatelessWidget {
  static const String routeName = '/help-support';
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
        backgroundColor: AppColors.primary,
      ),
      body: Center(
        child: Text(
          'Help & Support Screen - Coming Soon!',
          style: TextStyle(fontSize: 18, color: AppColors.primaryText),
        ),
      ),
    );
  }
}
