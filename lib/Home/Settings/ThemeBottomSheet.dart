import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Providers/AppConfigProvider.dart';
import 'package:todo_app/Theming/MyTheme.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({Key? key}) : super(key: key);

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var appProvider=Provider.of<AppConfigProvider>(context);
    var size=MediaQuery.of(context).size;
    return Container(
      color:appProvider.appTheme==ThemeMode.light?
      Colors.white:
      MyTheme.darkPrimaryColor,
      padding: EdgeInsets.symmetric(
        vertical: size.height *0.05,
        horizontal: size.width *0.04
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: (){
              appProvider.changeAppTheme(ThemeMode.light);
              Navigator.pop(context);
            },
            child:appProvider.appTheme==ThemeMode.light?
            selectedThemeWidget('Light'):
            unSelectedThemeWidget('Light')

          ),
          SizedBox(height: 30,),
          InkWell(
            onTap: (){
              appProvider.changeAppTheme(ThemeMode.dark);
              Navigator.pop(context);
            },

               child: appProvider.appTheme==ThemeMode.dark?
               selectedThemeWidget('Dark'):
               unSelectedThemeWidget('Dark')

          ),

        ],
      ),
    );
  }

  Widget selectedThemeWidget(String text){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,style: Theme.of(context).textTheme.titleLarge,),
        Icon(Icons.check_circle,color: Theme.of(context).primaryColor,)
      ],
    );
  }
  Widget unSelectedThemeWidget(String text){
    return Row(
      children: [
        Text(text,style: Theme.of(context).textTheme.titleLarge,),
      ],
    );
    
  }
}
