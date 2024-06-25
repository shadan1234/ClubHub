// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/constants/utils.dart';
import 'package:clubhub/features/auth/services/auth_service.dart';
import 'package:clubhub/features/profile/services/profile_services.dart';
import 'package:clubhub/features/settings/screen/setting_screen.dart';
import 'package:clubhub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? imageProfile;
  ProfileServices profileServices = ProfileServices();
  void _showLogoutConfirmationDialog(BuildContext context) {
    AuthService authService = AuthService();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                authService.logOut(context: context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error, // Logout button color
              ),
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Profile Picture"),
          content: const Text("Select a new profile picture from your gallery."),
          actions: [
            TextButton(
              onPressed: () async {

                
              
                imageProfile = await pickImage();
             
                if (imageProfile != null) {
                await  profileServices.updateProfileImage(
                      context: context, profileImage: imageProfile!);
                     setState(() {
                       
                     });
                }else{
                  showSnackBar(context, 'No Image Selected');
                }
                 Navigator.of(context).pop();
              },
              child: const Text("Select Image"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context,).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Account",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                
                  radius: 50,
                  backgroundImage: NetworkImage(
                    
                    user.image.isNotEmpty? user.image:
                    'https://www.seekpng.com/png/detail/966-9665317_placeholder-image-person-jpg.png')
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => _showEditProfileDialog(context),
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.accent,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              user.name, // Replace with the actual user's name
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              user.email, // Replace with the actual user's email
              style: const TextStyle(
                fontSize: 16.0,
                color: AppColors.secondaryText,
              ),
            ),
            const SizedBox(height: 24.0),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings, color: AppColors.primary),
              title: const Text('Settings',
                  style: TextStyle(color: AppColors.primaryText)),
              onTap: () {
                Navigator.pushNamed(context, SettingsScreen.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.help, color: AppColors.primary),
              title: const Text('Help & Support',
                  style: TextStyle(color: AppColors.primaryText)),
              onTap: () {
                Navigator.pushNamed(context, HelpSupportScreen.routeName);
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => _showLogoutConfirmationDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error, // Logout button color
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text(
                "Logout",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
