import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

Future<File?> pickImage() async {
  File? image;
  try {


    print('vah eih');
    var file = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (file != null && file.files.isNotEmpty) {
      image = File(file.files.single.path!);
      print("File selected: ${file.files.single.path}");
    } else {
      print("No file selected");
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return image;
}
