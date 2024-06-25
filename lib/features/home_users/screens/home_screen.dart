
import 'package:clubhub/commons/services/club_services.dart';
import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/features/home_users/widgets/clubcard_members.dart';
import 'package:clubhub/models/club.dart';
import 'package:clubhub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName='/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Club>? clubs;
  final ClubServices clubServices =ClubServices();
  @override
  void initState() {
    _fetchClubsForUser();
    super.initState();
  }
   void _fetchClubsForUser() async{
      clubs=   await clubServices.fetchClubsForUser(context: context);
setState(() {
  
});
   }
  @override
  Widget build(BuildContext context) {
     final user=Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome , ${user.name}', style: const TextStyle(color: Colors.white),),
        centerTitle: true, 
        backgroundColor: AppColors.primary,
      ),
      body: clubs==null ?const Center(child: CircularProgressIndicator(),):
      ListView.builder(
        itemCount: clubs!.length,
        itemBuilder: (context,index){
        return ClubCardMembers(club: clubs![index] ,);
      })
      ,
    );
  }
  

}