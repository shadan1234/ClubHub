import 'dart:convert';
import 'dart:io';

import 'package:clubhub/constants/error_handling.dart';
import 'package:clubhub/constants/global.dart';
import 'package:clubhub/constants/utils.dart';
import 'package:clubhub/models/user.dart';
import 'package:clubhub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

class ProfileServices{
  Future<void> updateProfileImage(
      {required BuildContext context,
     
      required File profileImage}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {

      final cloudinary = CloudinaryPublic('dwkaqsoto', 'daqdvyep');
      String imageUrl = '';
      
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(profileImage.path, folder: userProvider.user.token));
        imageUrl=(res.secureUrl);
      print(imageUrl);
Map<String, String> body = {
        'imageUrl': imageUrl, // Add image URL to the request body
      };
      http.Response response = await http.post(
        Uri.parse('$uri/update-profile-image'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(body),
      );
      print(response.body);
      // one way of doing this but what if some error happens then also this gets updated that's why resp ko store karo
      User user=userProvider.user;
     User updatedUser= user.copyWith(image: imageUrl);
      userProvider.setUserFromModel(updatedUser);
    // if (response.statusCode == 200) {
    //   User updatedUser = User.fromJson(response.body);
    //   if (context.mounted) {  // Check if the context is still mounted
    //     userProvider.setUserFromModel(updatedUser);
    //     print(userProvider.user.image);
    //     showSnackBar(context, 'Profile Pic updated successfully!');
    //   }
    // } else {
    //   if (context.mounted) {
    //     showSnackBar(context, 'Failed to update profile picture');
    //   }
    // }
     httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
           
            showSnackBar(context, 'Product Added successfully!');
            // Navigator.pop(context);
          });
    
  } catch (e) {
    if (context.mounted) {
      showSnackBar(context, e.toString());
    }
  }
}
}