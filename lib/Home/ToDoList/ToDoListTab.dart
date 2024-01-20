import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Home/ToDoList/TaskDetailsWidget.dart';
import 'package:todo_app/MyTheme.dart';

class ToDoListTab extends StatelessWidget {
  const ToDoListTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 90)),
          lastDate: DateTime.now().add(Duration(days: 365)),
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
            child: ListView.builder(itemBuilder: (context,index){
              return TaskDetailsWidget();
            },itemCount: 6,)
        )
      ],
    );
  }
}
