import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDay=DateTime.now();
  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
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
                    validator: (text){
                      if(text==null || text.isEmpty){
                        return 'Please Enter Your Task Title';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your Task Title'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    validator: (text){
                      if (text==null || text.isEmpty){
                        return 'Please Enter Your Task Description';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
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
                  onTap: ShowCalender,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${selectedDay.day}/${selectedDay.month}/${selectedDay.year}',
                      style:Theme.of(context).textTheme.titleMedium ,textAlign: TextAlign.center,),
                  ),
                ),
                ElevatedButton(onPressed: ()=>{
                  formkey.currentState?.validate(),
                },
                    child: Text('Add',style: Theme.of(context).textTheme.titleSmall,),
                style: ButtonStyle( backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),)
              ],
            )
            )
          ],
        ),
      ),
    );
  }

  void ShowCalender()async {
    var day=await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    setState(() {
      if(day!=null)
      selectedDay=day;
    });
  }
}
