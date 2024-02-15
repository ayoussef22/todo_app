import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/Models/MyUser.dart';
import 'package:todo_app/Models/Task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTaskCollection(String uId) {
    return getUserCollection().doc(uId).collection('tasks').withConverter<Task>(
        fromFirestore: (snapshot, options) =>
            Task.fromFireStore(snapshot.data()!),
        toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTasksToFireStore(Task task, String uId) {
    var taskCollection = getTaskCollection(uId);
    DocumentReference<Task> documentReference = taskCollection.doc();
    task.id = documentReference.id;
    return documentReference.set(task);
  }

  static Future<void> deleteTask(Task task, String uId) {
    return getTaskCollection(uId).doc(task.id).delete();
  }



  static Future<void> updateTask(Task task, String uId) {
    return getTaskCollection(uId).doc(task.id).update(task.toFireStore());
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, options) =>
                MyUser.fromFireStore(snapshot.data()!),
            toFirestore: (myUser, options) => myUser.toFireStore());
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUserCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    DocumentSnapshot<MyUser> documentSnapshot =
        await getUserCollection().doc(uId).get();
    return documentSnapshot.data();
  }

  static Future<void> userSignOut(String uId) async {
    return await FirebaseAuth.instance.signOut();
  }

  static Future<void> updateTaskStatus(String uId,Task task)async{
     getTaskCollection(uId).doc(task.id).update({
      'isDone': !task.isDone!
    });

  }
}
