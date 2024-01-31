import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/FirebaseUtils.dart';
import 'package:todo_app/Models/Task.dart';

class ListProvider extends ChangeNotifier{
  List<Task> tasksList=[];

  void getTasksFromFireStore()async{
    var taskCollection=FirebaseUtils.getTaskCollection();
    QuerySnapshot<Task>querySnapshot=await taskCollection.get();
    tasksList= querySnapshot.docs.map((doc) {
      return doc.data();
    } ).toList();
    notifyListeners();
  }

}