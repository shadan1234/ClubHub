import 'package:flutter/material.dart';

class TextFieldClubs extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final int maxlines;
  const TextFieldClubs({super.key, required this.controller, required this.labelText, this.maxlines=1});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
     
                controller: controller,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: labelText,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the $labelText';
                  }
                  return null;
                },
                maxLines: maxlines,
              );
  }
}