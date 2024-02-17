import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Authentication/Login/LoginScreen.dart';
import 'package:todo_app/Authentication/Register/RegisterScreen.dart';
import 'package:todo_app/Home/HomeScreen.dart';
import 'package:todo_app/Home/ToDoList/TaskEditScreen.dart';
import 'package:todo_app/Providers/AppConfigProvider.dart';
import 'package:todo_app/Providers/userAuthProvider.dart';
import 'package:todo_app/Providers/ListProvider.dart';
import 'package:todo_app/Theming/MyTheme.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();


  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: ((context) => AppConfigProvider())),
    ChangeNotifierProvider(create: (context)=>ListProvider()),
    ChangeNotifierProvider(create: (context)=>userAuthProvider()),
  ],child: MyApp(),));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
class MyApp extends StatelessWidget{
  late AppConfigProvider appProvider;
  @override
  Widget build(BuildContext context) {
     appProvider=Provider.of<AppConfigProvider>(context);
     initSharedPref();
    return MaterialApp(

      routes: {
        HomeScreen.routeName:(context)=>HomeScreen(),
        LoginScreen.routeName:(context)=>LoginScreen(),
        RegisterScreen.routeName:(context)=>RegisterScreen(),
        TaskEditScreen.routeName:(context)=>const TaskEditScreen(),
      },
      initialRoute:LoginScreen.routeName ,
      theme: MyTheme.lightTheme,
      darkTheme:MyTheme.darkTheme ,
      themeMode: appProvider.appTheme,
    );
  }
  void initSharedPref()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String tempTheme=prefs.getString('theme')??'light';
    if(tempTheme=='light'){
      appProvider.changeAppTheme(ThemeMode.light);
    }else{
      appProvider.changeAppTheme(ThemeMode.dark);
    }
  }
}