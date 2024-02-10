import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Utils/FirebaseUtils.dart';
import 'package:todo_app/Models/Task.dart';

class ListProvider extends ChangeNotifier{
  List<Task> tasksList=[];
  DateTime selectDay=DateTime.now();

  void refreshTasks(String uId)async{
    var taskCollection=FirebaseUtils.getTaskCollection(uId)
        .orderBy("dateTime");
    QuerySnapshot<Task>querySnapshot=await taskCollection.get();
    tasksList= querySnapshot.docs.map((doc) {
      return doc.data();
    } ).toList();

    //filter list (selectDay)
    tasksList=tasksList.where((task) {
      if(task.dateTime?.day==selectDay.day&&
         task.dateTime?.month==selectDay.month&&
         task.dateTime?.year==selectDay.year){
        return true;
      }
      return false;
    }).toList();

    notifyListeners();
  }

  void changeDate(DateTime newDate){
    selectDay=newDate;
    notifyListeners();
  }

}