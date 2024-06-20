import 'package:flutter/material.dart';

class TextFieldClubs extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  const TextFieldClubs({super.key, required this.controller, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: labelText,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the $labelText';
                  }
                  return null;
                },
              );
  }
}