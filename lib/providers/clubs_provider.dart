import 'package:clubhub/models/club.dart';
import 'package:flutter/material.dart';

class ClubProvider extends ChangeNotifier{
  List<Club>clubs=[];

  void setClubs(List<Club>source){
    clubs=source;
   notifyListeners();
  }

}