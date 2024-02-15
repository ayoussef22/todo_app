import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Authentication/Login/LoginScreen.dart';
import 'package:todo_app/Authentication/Register/RegisterScreen.dart';
import 'package:todo_app/Home/HomeScreen.dart';
import 'package:todo_app/Home/ToDoList/TaskEditScreen.dart';
import 'package:todo_app/Providers/userAuthProvider.dart';
import 'package:todo_app/Providers/ListProvider.dart';
import 'package:todo_app/Theming/MyTheme.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=>ListProvider()),
    ChangeNotifierProvider(create: (context)=>userAuthProvider()),
  ],child: MyApp(),));
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(

      routes: {
        HomeScreen.routeName:(context)=>HomeScreen(),
        LoginScreen.routeName:(context)=>LoginScreen(),
        RegisterScreen.routeName:(context)=>RegisterScreen(),
        TaskEditScreen.routeName:(context)=>const TaskEditScreen(),
      },
      initialRoute:RegisterScreen.routeName ,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.DarkTheme,
    );
  }
}