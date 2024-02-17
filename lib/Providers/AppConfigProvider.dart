import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier{

  ThemeMode appTheme=ThemeMode.light;

  void changeAppTheme(ThemeMode newTheme){
    if(appTheme==newTheme){
      return;
    }
    appTheme=newTheme;
    notifyListeners();
  }
}