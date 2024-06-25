// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:clubhub/commons/services/club_application_services.dart';
import 'package:clubhub/commons/widgets/textfiled_clubs.dart';
import 'package:clubhub/constants/utils.dart';
import 'package:clubhub/models/club.dart';
import 'package:clubhub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

class ApplicationScreen extends StatefulWidget {
  final Club club;
  static const String routeName = '/application-screen';

  const ApplicationScreen({super.key, required this.club});

  @override
  _ApplicationScreenState createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  File? pdfFile;
  final ClubApplicationServices clubApplicationServices = ClubApplicationServices();

  Future<void> _pickPDFFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        pdfFile = File(result.files.single.path!);
      });
    }
  }

  void _submitForm() {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    // print(pdfFile);
    if (_formKey.currentState!.validate()) {
      if (pdfFile != null) {
        clubApplicationServices.applyForClub(
          description: _descriptionController.text.trim(),
          context: context,
          file: pdfFile!,
          clubId: widget.club.id,
          name: userProvider.user.name,
        );
      } else {
        showSnackBar(context, 'Please attach a PDF file.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tell About Yourself'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFieldClubs(
                controller: _descriptionController,
                labelText: 'Description',
                maxlines: 4,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickPDFFile,
                child: const Text('Attach Relevant Docs in Pdf'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
