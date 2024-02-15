import 'package:flutter/material.dart';
import 'package:todo_app/Theming/MyTheme.dart';

class BottomSheetTextField extends StatelessWidget {
  void Function(String)? onChanged;
  String? Function(String?)? validation;
  String? hintText;
  int? maxLines;
  BottomSheetTextField({required this.onChanged,required this.validation,this.hintText,this.maxLines});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color:
        MyTheme.darkPrimaryColor
       ,
      ),
      onChanged:onChanged ,

      validator:validation ,
      decoration:  InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color:
                  MyTheme.greyColor

              )
          ),
          hintText: hintText,
          hintStyle: TextStyle(color:

          MyTheme.darkPrimaryColor
          )
      ),
      maxLines: maxLines,
    );
  }
}
