import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/Models/Task.dart';

class FirebaseUtils{
static CollectionReference<Task> getTaskCollection(){
  return FirebaseFirestore.instance.collection('tasks')
      .withConverter<Task>(
      fromFirestore: (snapshot, options) =>Task.fromFireStore(snapshot.data()!),
      toFirestore:(task,options)=>task.toFireStore()
  );
}

static Future<void> addTasksToFireStore(Task task){
  var taskCollection=getTaskCollection();
  DocumentReference<Task>documentReference=taskCollection.doc();
  task.id=documentReference.id;
  return documentReference.set(task);
}
}