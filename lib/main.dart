import 'package:flutter/material.dart';
import 'package:todo_app/Home/HomeScreen.dart';
import 'package:todo_app/MyTheme.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(

      routes: {
        HomeScreen.routeName:(context)=>HomeScreen(),
      },
      initialRoute:HomeScreen.routeName ,
      theme: MyTheme.lightTheme,
    );
  }
}