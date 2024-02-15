import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
    String label;
    TextInputType keyboardType;
    Widget textFormFieldIcon;
    bool obscureText;
    String? Function(String?)? validation;
    TextEditingController textController;
    CustomTextFormField({required this.label,
      this.keyboardType=TextInputType.text,
      required this. textFormFieldIcon,
      required this.textController,
      this.obscureText=false,
      required this.validation
    });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(

        keyboardType: keyboardType,
        controller: textController,
        obscureText: obscureText,
        validator: validation,
        decoration: InputDecoration(
          label: Text(label),
          prefixIcon: textFormFieldIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 3,color: Colors.black)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 2,color: Colors.black)
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 2,color: Colors.red),
          ),

        ),

      ),
    );
  }
}
