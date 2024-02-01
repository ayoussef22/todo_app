import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/FirebaseUtils.dart';
import 'package:todo_app/Models/Task.dart';
import 'package:todo_app/Providers/ListProvider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {

  DateTime selectedDay=DateTime.now();
  String title='';
  String description='';
  late ListProvider provider;
  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    provider=Provider.of<ListProvider>(context);
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text('Add Your Task',
            style: Theme.of(context).textTheme.titleMedium,),
            Form(
              key: formkey,
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    onChanged: (text){
                      title=text;
                    },

                    validator: (text){
                      if(text==null || text.isEmpty){
                        return 'Please Enter Your Task Title';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your Task Title'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    onChanged: (text){
                      description=text;
                    },
                    validator: (text){
                      if (text==null || text.isEmpty){
                        return 'Please Enter Your Task Description';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your Task Description'
                    ),
                    maxLines: 4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text('Select day',
                    style:Theme.of(context).textTheme.titleMedium),
                ),
                InkWell(
                  onTap: showCalender,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${selectedDay.day}/${selectedDay.month}/${selectedDay.year}',
                      style:Theme.of(context).textTheme.titleMedium ,textAlign: TextAlign.center,),
                  ),
                ),
                ElevatedButton(onPressed: addTask,
                style: ButtonStyle( backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
                    child: Text('Add',style: Theme.of(context).textTheme.titleSmall,),)
              ],
            )
            )
          ],
        ),
      ),
    );
  }

  void addTask(){
    if(formkey.currentState?.validate()==true){
      // add task to firebase
      Task task=Task(
          title: title,
          description: description,
          dateTime: selectedDay);
      FirebaseUtils.addTasksToFireStore(task).timeout(
        Duration(seconds: 1),
        onTimeout: (){
          print('task added successfully');
          provider.refreshTasks();
          Navigator.pop(context);
        }
      );

    }
  }

  void showCalender()async {
    var day=await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    setState(() {
      if(day!=null) {
        selectedDay=day;
      }
      return;
    });
  }
}
