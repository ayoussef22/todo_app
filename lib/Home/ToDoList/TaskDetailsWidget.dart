import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home/ToDoList/TaskEditScreen.dart';
import 'package:todo_app/Utils/DialogUtils.dart';
import 'package:todo_app/Utils/FirebaseUtils.dart';
import 'package:todo_app/Models/Task.dart';
import 'package:todo_app/Providers/ListProvider.dart';
import 'package:todo_app/Providers/userAuthProvider.dart';
import 'package:todo_app/Theming/MyTheme.dart';

class TaskDetailsWidget extends StatefulWidget {
  Task task;
  TaskDetailsWidget({required this.task});

  @override
  State<TaskDetailsWidget> createState() => _TaskDetailsWidgetState();
}

class _TaskDetailsWidgetState extends State<TaskDetailsWidget> {
  late ListProvider listProvider ;

  late userAuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
     listProvider=Provider.of<ListProvider>(context);
     authProvider=Provider.of<userAuthProvider>(context);
    var size=MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: size.height*0.02,
          horizontal: size.width*0.03
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Slidable(
        closeOnScroll: true,
        startActionPane: ActionPane(
          extentRatio: 0.4,
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (context){
                  deleteTaskWidget();
                },
              backgroundColor: MyTheme.redColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),),
              SlidableAction(
                onPressed: (context){
                  Navigator.of(context).pushNamed(TaskEditScreen.routeName,
                  arguments: widget.task);
                },
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),),
            ]),
        child: Container(
          padding: const EdgeInsets.all(20),
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
                    color:widget.task.isDone==true?
                    MyTheme.greenColor:
                    Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15)
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      Text(widget.task.title??'',
                      style:widget.task.isDone==true?
                      Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: MyTheme.greenColor):
                      Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).primaryColor),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.task.description??'',
                        style:
                        Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: MyTheme.darkPrimaryColor
                        )
                        ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  FirebaseUtils.updateTaskStatus(authProvider.currentUser!.id!,
                      widget.task);
                  listProvider.refreshTasks(authProvider.currentUser!.id!);
                  setState(() {

                  });
                },
                child:widget.task.isDone==true?
                    Text('Done...',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: MyTheme.greenColor
                    ),):
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
                ),
              )
            ],
          )
          ),
      ),
    );
  }

  void deleteTaskWidget(){
    DialogUtils.showMessage(context, 'Are You Sure To Delete This Task ?'
    ,posActionName: 'Yes',posAction: (){
          FirebaseUtils.deleteTask(widget.task,authProvider.currentUser!.id!);
          listProvider.refreshTasks(authProvider.currentUser!.id!);
        }
        ,negActionName: 'No',
    );

  }
}
