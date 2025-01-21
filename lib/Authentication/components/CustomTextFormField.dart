import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Providers/AppConfigProvider.dart';
import 'package:todo_app/Theming/MyTheme.dart';

class CustomTextFormField extends StatelessWidget {
  String label;
  TextInputType keyboardType;
  Widget textFormFieldIcon;
  bool obscureText;
  String? Function(String?)? validation;
  TextEditingController textController;

  CustomTextFormField(
      {required this.label,
      this.keyboardType = TextInputType.text,
      required this.textFormFieldIcon,
      required this.textController,
      this.obscureText = false,
      required this.validation});

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppConfigProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: textController,
        obscureText: obscureText,
        validator: validation,
        decoration: InputDecoration(
          label: Text(label),
          labelStyle: TextStyle(
            color: appProvider.appTheme == ThemeMode.light
                ? MyTheme.darkPrimaryColor
                : Colors.white,
          ),
          prefixIcon: textFormFieldIcon,
          prefixIconColor: appProvider.appTheme == ThemeMode.light
              ? MyTheme.darkPrimaryColor
              : Colors.white,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 3,
                color: appProvider.appTheme == ThemeMode.light
                    ? MyTheme.darkPrimaryColor
                    : Colors.white,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 2,
                color: appProvider.appTheme == ThemeMode.light
                    ? MyTheme.darkPrimaryColor
                    : Colors.white,
              )),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 2, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
