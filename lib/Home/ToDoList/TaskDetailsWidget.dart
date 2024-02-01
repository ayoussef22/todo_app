import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/FirebaseUtils.dart';
import 'package:todo_app/Models/Task.dart';
import 'package:todo_app/Providers/ListProvider.dart';
import 'package:todo_app/Theming/MyTheme.dart';

class TaskDetailsWidget extends StatelessWidget {
  Task task;
  TaskDetailsWidget({required this.task});
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<ListProvider>(context);
    var size=MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: size.height*0.02,
          horizontal: size.width*0.03
      ),
      decoration: BoxDecoration(
          color: MyTheme.redColor,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Slidable(
        closeOnScroll: true,
        startActionPane: ActionPane(
          extentRatio: 0.2,
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (context){
                  FirebaseUtils.deleteTask(task);
                  provider.refreshTasks();
                },
              backgroundColor: MyTheme.redColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),),
            ]),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width*0.01,
                height: size.height*0.13,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15)
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(task.title??'',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).primaryColor
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(task.description??'',style: Theme.of(context).textTheme.titleMedium,),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: size.height*0.015,
                  horizontal: size.width*0.05
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: const Icon(Icons.check,color: Colors.white,),
              )
            ],
          )
          ),
      ),
    );
  }
}
