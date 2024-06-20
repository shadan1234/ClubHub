import 'dart:io';
import 'package:clubhub/commons/services/club_services.dart';
import 'package:clubhub/commons/widgets/textfiled_clubs.dart';
import 'package:clubhub/constants/colors.dart';
import 'package:clubhub/constants/utils.dart';
import 'package:clubhub/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

class CreateClubScreen extends StatefulWidget {
  const CreateClubScreen({super.key});

  @override
  _CreateClubScreenState createState() => _CreateClubScreenState();
}

class _CreateClubScreenState extends State<CreateClubScreen> {
  final _formKey = GlobalKey<FormState>();
  final _clubNameController = TextEditingController();
  final _clubTypeController = TextEditingController();
  final _clubDescriptionController = TextEditingController();
  final _managerNameController = TextEditingController();
  final _managerEmailController = TextEditingController();
  final _managerPasswordController = TextEditingController();
  final AuthService authService = AuthService();
  final ClubServices clubServices=ClubServices();
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await pickImage();
    print(pickedFile);
    
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
        print('aballl');
        print(_image);
      });
    }
  }

  void _submitForm() async{
    if (_formKey.currentState!.validate()) {
      print('123');
      print(_image);
 await clubServices.createClub(context: context, nameOfClub: _clubNameController.text, type: _clubTypeController.text , description: _clubDescriptionController.text, image: _image!, emailManager: _managerEmailController.text, passwordManager: _managerPasswordController.text, nameManager: _managerNameController.text);
   print('mic');
   
 
          showSnackBar(context, 'Club Created Successfully');
      print('Form submitted successfully');
    }
  }

  @override
  void dispose() {
    _clubNameController.dispose();
    _clubTypeController.dispose();
    _clubDescriptionController.dispose();
    _managerNameController.dispose();
    _managerEmailController.dispose();
    _managerPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Club'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFieldClubs(
                  controller: _clubNameController, labelText: 'Club Name'),
              const SizedBox(height: 16.0),
              TextFieldClubs(
                  controller: _clubTypeController, labelText: 'Type Of Club'),
              const SizedBox(height: 16.0),
              TextFieldClubs(
                  controller: _clubDescriptionController,
                  labelText: 'Description'),
              const SizedBox(height: 16.0),
              _image == null
                  ? TextButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.add_a_photo),
                      label: const Text('Add Club Image'),
                    )
                  : Image.file(_image!),
              const SizedBox(height: 16.0),
              TextFieldClubs(
                  controller: _managerNameController,
                  labelText: 'Manager Name'),
              const SizedBox(height: 16.0),
              TextFieldClubs(
                  controller: _managerEmailController,
                  labelText: 'Manager Email'),
              const SizedBox(height: 16.0),
              TextFieldClubs(
                  controller: _managerPasswordController,
                  labelText: 'Manager Password'),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  'Create Club',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
