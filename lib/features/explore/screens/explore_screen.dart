import 'package:clubhub/commons/widgets/club_card.dart';
import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/commons/services/club_services.dart';
import 'package:clubhub/models/club.dart';
import 'package:clubhub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final ClubServices clubServices=ClubServices();
   List<Club>?clubs;
  @override
  void initState() {
   _fetchAllClubs();
    super.initState();
  }
  void _fetchAllClubs() async{
            clubs=    await clubServices.fetchAllClubs();
            setState(() {
              
            });
  }
  @override
  Widget build(BuildContext context) {
     final user=Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome , ${user.name}'),
        centerTitle: true, 
        backgroundColor: AppColors.primary,
      ),
      body: clubs==null? Center(child: CircularProgressIndicator(),): 
      ListView.builder(
        itemCount: clubs!.length,
        itemBuilder: (context,index){
        return ClubCard(club: clubs![index] ,);
      })
       ,
    );
  }
}