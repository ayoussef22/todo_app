import 'package:flutter/material.dart';
import 'package:todo_app/Theming/MyTheme.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({Key? key}) : super(key: key);

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: size.height *0.05,
        horizontal: size.width *0.04
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: (){

              Navigator.pop(context);
            },
            child:
            selectedThemeWidget('Light')

          ),
          SizedBox(height: 30,),
          InkWell(
            onTap: (){

              Navigator.pop(context);
            },

               child: selectedThemeWidget('Dark')

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
