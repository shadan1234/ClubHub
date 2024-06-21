import 'package:clubhub/commons/services/club_application_services.dart';
import 'package:clubhub/commons/services/club_services.dart';
import 'package:clubhub/models/user.dart';
import 'package:clubhub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:clubhub/models/club.dart';
import 'package:clubhub/constants/colors.dart';
import 'package:provider/provider.dart';

class ClubDetailScreen extends StatefulWidget {
  static const String routeName='/Clubs-Details-Screen';
  final Club club;

  ClubDetailScreen({super.key, required this.club});

  @override
  State<ClubDetailScreen> createState() => _ClubDetailScreenState();
}

class _ClubDetailScreenState extends State<ClubDetailScreen> {
  final ClubApplicationServices clubApplicationServices=ClubApplicationServices();
  void applyForClub(String name){
    clubApplicationServices.applyForClub(context: context, clubId: widget.club.id, name:name );
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider=Provider.of<UserProvider>(context,listen: false);
   
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.club.nameOfClub),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.club.image,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Align( 
              alignment: Alignment.center,
              child: Text(
                widget.club.nameOfClub,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Type: ${widget.club.type}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 20),
            Text(
              widget.club.description,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Work Done by Club:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.club.workDoneByClub.isEmpty
                  ? 'No work done yet.'
                  : widget.club.workDoneByClub,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 40),
            if(userProvider.user.type=='user')
            Center(
              child: ElevatedButton(
                onPressed: () {
                  applyForClub(userProvider.user.name);
                },
                child: Text('Apply' ,style:TextStyle(fontSize: 18,color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18,color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
