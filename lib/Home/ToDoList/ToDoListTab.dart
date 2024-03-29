import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home/ToDoList/TaskDetailsWidget.dart';
import 'package:todo_app/Providers/AppConfigProvider.dart';
import 'package:todo_app/Providers/ListProvider.dart';
import 'package:todo_app/Providers/userAuthProvider.dart';
import 'package:todo_app/Theming/MyTheme.dart';

class ToDoListTab extends StatefulWidget {
  @override
  State<ToDoListTab> createState() => _ToDoListTabState();
}

class _ToDoListTabState extends State<ToDoListTab> {

  @override
  Widget build(BuildContext context) {
    var appProvider=Provider.of<AppConfigProvider>(context);
    var listProvider=Provider.of<ListProvider>(context);
    var authProvider=Provider.of<userAuthProvider>(context);

      listProvider.refreshTasks(authProvider.currentUser!.id!);

    return Column(
      children: [
        CalendarTimeline(
          initialDate: listProvider.selectDay,
          firstDate: DateTime.now().subtract(const Duration(days: 90)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date) {
            listProvider.changeDate(date,authProvider.currentUser!.id!);
          },
          leftMargin: 10,
          monthColor:appProvider.appTheme==ThemeMode.light?
          MyTheme.darkPrimaryColor:Colors.white,
          dayColor:appProvider.appTheme==ThemeMode.light?
          MyTheme.darkPrimaryColor:Colors.white,
          activeDayColor:appProvider.appTheme==ThemeMode.light?
          Colors.white:
          MyTheme.darkPrimaryColor,
          activeBackgroundDayColor:appProvider.appTheme==ThemeMode.light?
          MyTheme.primaryColor:
          Colors.white,
          dotsColor: appProvider.appTheme==ThemeMode.light?
          Colors.white:
          MyTheme.darkPrimaryColor,
          locale: 'en_ISO',
        ),
        Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return TaskDetailsWidget(task: listProvider.tasksList[index],);
            }, itemCount: listProvider.tasksList.length,)
        )
      ],
    );
  }


}
