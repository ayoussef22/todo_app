import 'package:flutter/material.dart';

class MyTheme{
  static Color primaryColor=Color(0xff5D9CEC);
  static Color backgroundColor=Color(0xffDFECDB);
  static Color greenColor=Color(0xff61E757);
  static Color redColor=Color(0xffEC4B4B);
  static Color greyColor=Color(0xffa8abbf);

 static ThemeData lightTheme=ThemeData(
   useMaterial3: false,
   primaryColor: primaryColor,
   appBarTheme: AppBarTheme(
     backgroundColor: primaryColor,
     elevation: 0,
     titleTextStyle: TextStyle(
       fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white
     )
   ),
   scaffoldBackgroundColor: backgroundColor,
   bottomNavigationBarTheme: BottomNavigationBarThemeData(
     selectedItemColor: primaryColor,
     unselectedItemColor: greyColor,
     backgroundColor: Colors.transparent,
     elevation: 0,
   ),
   floatingActionButtonTheme: FloatingActionButtonThemeData(
     backgroundColor: primaryColor,
     foregroundColor: Colors.white,
   ),
   textTheme: TextTheme(
     titleMedium:TextStyle(
       fontWeight: FontWeight.bold,fontSize: 18
     ),
     titleSmall: TextStyle(
         fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white
     ),
   )


  );
}