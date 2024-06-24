import 'dart:convert';

import 'package:clubhub/constants/error_handling.dart';
import 'package:clubhub/constants/global.dart';
import 'package:clubhub/constants/utils.dart';
import 'package:clubhub/models/message.dart';
import 'package:clubhub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
class MessageServices{
  Future<void> sendMessage({
    required BuildContext context,
    required String name,
    required String clubId,
    required String message,
    
  })async{
    UserProvider userProvider=Provider.of<UserProvider>(context,listen:false);
    Message messages=Message(id: '', message: message, senderId: userProvider.user.id, clubId: clubId, createdAt: DateTime.now(), name: name);
    try {
      http.Response res= await http.post(Uri.parse('$uri/send-message'),
        headers: {
          'Content-Type':'application/json',
          'x-auth-token': userProvider.user.token
        },
        body: messages.toJson()
        );
        print(res.body);
        httpErrorHandle(response: res, context: context, onSuccess: (){
          showSnackBar(context, 'Message sent');
        });
    } catch (e) {
       showSnackBar(context, e.toString());
    }
      
  }

  Future<List<Message>> fetchMessages({
    required BuildContext context,
    required String clubId,

  })async{
     UserProvider userProvider=Provider.of<UserProvider>(context,listen:false);
     List<Message> messages=[];
      try {
      http.Response res=   await http.get(Uri.parse('$uri/fetch-messages/$clubId'),
         headers: {
          'Content-Type':'application/json',
          'x-auth-token':userProvider.user.token
         }
         );
         print(res.body);
         List<dynamic> decodedJson=jsonDecode(res.body);
        messages= decodedJson.map((unit)=> Message.fromMap(unit as Map<String,dynamic>)).toList();
         httpErrorHandle(response: res, context: context, onSuccess: (){
          
         });
      } catch (e) {
        showSnackBar(context, e.toString());
      }
      return messages;
  }
}