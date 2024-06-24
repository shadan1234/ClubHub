import 'dart:convert';

import 'package:clubhub/constants/bottom_page.dart';
import 'package:clubhub/constants/error_handling.dart';
import 'package:clubhub/constants/global.dart';
import 'package:clubhub/constants/utils.dart';
import 'package:clubhub/features/auth/screens/login_screen.dart';
import 'package:clubhub/features/club_manager/screens/application_screen.dart';
import 'package:clubhub/features/club_manager/screens/club_manager_bottom_bar.dart';
import 'package:clubhub/features/super_admin/screens/super_admin_bottom_bar.dart';
import 'package:clubhub/main.dart';
import 'package:clubhub/models/user.dart';
import 'package:clubhub/providers/user_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthService {
  // sign up user
  Future<void> signUpUser(
    
    {
      String? type,
      String? idOfClub,
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }
  
  ) async {
     String? token = await FirebaseMessaging.instance.getToken();
    
   
    try {
      User user = User(
          id: '',
          name: name,
          password: password,
          
          type: type??"",
          token: "",
          email: email,
         image:'', clubOwned: idOfClub??'', clubs: [], fcmToken: token??""
          );
        
      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, 'Account created! Login with same credential');
          });
      
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
     
      // print(res.body);
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
           await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
   
            Navigator.pushNamedAndRemoveUntil(
              context,
              User.fromJson(res.body).type=='user'?
              BottomBar.routeName:
              User.fromJson(res.body).type=='super'?  SuperAdminBottomBar.routeName : (ClubManagerBottomBar.routeName ), 
              (route) => false,
               arguments: User.fromJson(res.body).type == 'club-manager'
      ? Provider.of<UserProvider>(context, listen: false).user.clubOwned
      : null,
            );
          });
      // print(res.statusCode);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });
      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        // get user data
        http.Response userRes = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
        setupFirebaseMessaging(context);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
   void logOut({required BuildContext context})async{
        try {
           SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
           await sharedPreferences.setString('x-auth-token', '');
           Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false ,);
        } catch (e) {
          showSnackBar(context, e.toString());
        }
  }

}

void setupFirebaseMessaging(BuildContext context) async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }

  String? token = await messaging.getToken();
  if (token != null) {
     sendFCMTokenToServer(token,context);
  }

  // Handle token refresh
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
  
    sendFCMTokenToServer(newToken,context);
  });
}


void sendFCMTokenToServer(String token,BuildContext context) async {
 final UserProvider userProvider=Provider.of<UserProvider>(context,listen:false);
  final response = await http.post(
    Uri.parse('$uri/update-fcm-token'),
    headers: {
      'Content-Type': 'application/json',
      'x-auth-token': userProvider.user.token, 
    },
    body: jsonEncode({'fcmToken': token}),

  );
 print(response.body);

}