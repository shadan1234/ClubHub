import 'dart:convert';
import 'package:clubhub/constants/error_handling.dart';
import 'package:clubhub/constants/utils.dart';
import 'package:clubhub/models/notification.dart';
import 'package:clubhub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:clubhub/constants/global.dart';
import 'package:provider/provider.dart';

class NotificationService {

  Future<void> sendNotification({
    required BuildContext context,
    required String recipientType,
    required String message,
    required String title,
    required String clubId,
  }) async {
     final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      NotificationModel notification=NotificationModel(id: '', title: title, message: message, clubId: clubId, recipientType: recipientType, createdAt: DateTime.now()

      );

      final response = await http.post(
        Uri.parse('$uri/send-notification'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,

        },
        body: notification.toJson()
      );
 print(response.body);
     
      httpErrorHandle(response: response, context: context, onSuccess: (){
          showSnackBar(context, 'Notification sent successfully');
      });
    } catch (e) {
      showSnackBar(context, e.toString());
      throw Exception(e.toString());
    }
  }
Future<List<NotificationModel>> fetchNotifications({
  required BuildContext context,
   
}) async{
  List<NotificationModel>list=[];
  final UserProvider userProvider=Provider.of<UserProvider>(context,listen: false);
    try {
      http.Response res= await http.get(Uri.parse('$uri/fetch-notifications') , 
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,

        },
       );
print(res.body);
List<dynamic> decodedJson= jsonDecode(res.body);
   list= (decodedJson.map((model)=>  NotificationModel.fromMap(model as Map<String,dynamic>) )).toList() ; 
   httpErrorHandle(response: res, context: context, onSuccess: (){});

    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return list;
      
}

}
