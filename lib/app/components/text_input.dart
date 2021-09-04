import 'package:conversordemoeda/app/controllers/home_controller.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final Function onChanged;
  final String label;
  final String prefix;

  const TextInput({this.onChanged, this.label, this.prefix});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        prefixText: prefix,
      ),
      style: TextStyle(color: Colors.amber, fontSize: 25.0),
    );
  }
}
