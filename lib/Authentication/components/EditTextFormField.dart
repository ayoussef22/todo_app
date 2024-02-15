import 'package:flutter/material.dart';

class EditTextFormField extends StatelessWidget {
String label;
String? intialValue;
void Function(String)? onChange;
EditTextFormField({required this.label, required this.onChange,this.intialValue});
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      initialValue: intialValue,
      onChanged:onChange,
      decoration: InputDecoration(
        label: Text(label),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 3,color: Colors.black)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 2,color: Colors.black)
        ),
      ),
    );
  }
}
