import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Providers/AppConfigProvider.dart';
import 'package:todo_app/Theming/MyTheme.dart';

class BottomSheetTextField extends StatelessWidget {
  void Function(String)? onChanged;
  String? Function(String?)? validation;
  String? hintText;
  int? maxLines;
  BottomSheetTextField({required this.onChanged,required this.validation,this.hintText,this.maxLines});
  @override
  Widget build(BuildContext context) {
    var appProvider=Provider.of<AppConfigProvider>(context);
    return TextFormField(
      style: TextStyle(
        color:appProvider.appTheme==ThemeMode.light?
        MyTheme.darkPrimaryColor:
            Colors.white
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
          appProvider.appTheme==ThemeMode.light?
          MyTheme.darkPrimaryColor:
              Colors.white
          )
      ),
      maxLines: maxLines,
    );
  }
}
