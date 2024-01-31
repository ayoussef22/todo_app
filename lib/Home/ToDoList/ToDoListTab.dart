import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home/ToDoList/TaskDetailsWidget.dart';
import 'package:todo_app/Providers/ListProvider.dart';
import 'package:todo_app/Theming/MyTheme.dart';

class ToDoListTab extends StatefulWidget {
  @override
  State<ToDoListTab> createState() => _ToDoListTabState();
}

class _ToDoListTabState extends State<ToDoListTab> {

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<ListProvider>(context);
    if(provider.tasksList.isEmpty){
      provider.getTasksFromFireStore();
    }
    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 90)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date) => print(date),
          leftMargin: 10,
          monthColor: Colors.black,
          dayColor: Colors.black,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: MyTheme.primaryColor,
          dotsColor: Colors.white,
          locale: 'en_ISO',
        ),
        Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return TaskDetailsWidget(task: provider.tasksList[index],);
            }, itemCount: provider.tasksList.length,)
        )
      ],
    );
  }

}
