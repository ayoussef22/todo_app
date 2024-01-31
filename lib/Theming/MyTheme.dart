import 'package:flutter/material.dart';

class MyTheme{
  static Color primaryColor=const Color(0xff5D9CEC);
  static Color backgroundColor=const Color(0xffDFECDB);
  static Color greenColor=const Color(0xff61E757);
  static Color redColor=const Color(0xffEC4B4B);
  static Color greyColor=const Color(0xffa8abbf);

 static ThemeData lightTheme=ThemeData(
   useMaterial3: false,
   primaryColor: primaryColor,
   appBarTheme: AppBarTheme(
     backgroundColor: primaryColor,
     elevation: 0,
     titleTextStyle: const TextStyle(
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
   textTheme: const TextTheme(
     titleMedium:TextStyle(
       fontWeight: FontWeight.bold,fontSize: 18
     ),
     titleSmall: TextStyle(
         fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white
     ),
   )


  );
}