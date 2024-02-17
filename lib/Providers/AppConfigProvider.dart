import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier{

  ThemeMode appTheme=ThemeMode.light;

  void changeAppTheme(ThemeMode newTheme)async{
    if(appTheme==newTheme){
      return;
    }
    appTheme=newTheme;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', newTheme==ThemeMode.light?'light':'dark');
    notifyListeners();
  }


}