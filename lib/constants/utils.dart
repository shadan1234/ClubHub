import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

Future<File?> pickImage() async {
  File? image;
  try {


 
    var file = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (file != null && file.files.isNotEmpty) {
      image = File(file.files.single.path!);
     
    } else {
      print("No file selected");
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return image;
}

Future<File?> pickPdfFile() async {
  File? pdf;
  try {


  FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
   
    if (result != null && result.files.isNotEmpty) {
      pdf = File(result.files.single.path!);
     
    } else {
      print("No file selected");
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return pdf;
}

