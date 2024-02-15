import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home/Settings/ThemeBottomSheet.dart';
import 'package:todo_app/Theming/MyTheme.dart';

class SettingsTab extends StatefulWidget {

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Card(
      elevation: 20,
      margin: const EdgeInsets.all(30),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: size.height *0.02,
          vertical: size.width*0.1
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Mode',style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: MyTheme.darkPrimaryColor
            ),),
            InkWell(
              onTap: onSelectThemeClick,
              child: Container(
                margin: EdgeInsets.only(top: size.height*0.04),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color:
                  Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20)

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                    'Light',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white
                    ),),
                    Icon(Icons.arrow_drop_down_circle_rounded,color: Colors.white,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onSelectThemeClick() {
    showModalBottomSheet(context: context,
        builder: (context)=>ThemeBottomSheet());
  }
}
