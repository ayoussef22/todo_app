import 'package:flutter/material.dart';
import 'package:todo_app/Models/MyUser.dart';

class userAuthProvider extends ChangeNotifier{
  MyUser? currentUser;

  void changeUser(MyUser newUser){
    currentUser=newUser;
    notifyListeners();
  }
}