import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home/ToDoList/TaskTextFeildComponents/EditTextFormField.dart';
import 'package:todo_app/Home/HomeScreen.dart';
import 'package:todo_app/Models/Task.dart';
import 'package:todo_app/Providers/AppConfigProvider.dart';
import 'package:todo_app/Providers/userAuthProvider.dart';
import 'package:todo_app/Theming/MyTheme.dart';
import 'package:todo_app/Utils/FirebaseUtils.dart';

class TaskEditScreen extends StatelessWidget {
  static const String routeName = 'edit screen';

  const TaskEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments as Task;
    var authProvider = Provider.of<userAuthProvider>(context);
    var appProvider = Provider.of<AppConfigProvider>(context);

    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(arg.title ?? ''),
        ),
        body: Card(
          margin: const EdgeInsets.all(30),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Edit Your Task',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: MyTheme.darkPrimaryColor),
                  textAlign: TextAlign.center,
                ),
                const Spacer(
                  flex: 2,
                ),
                EditTextFormField(
                  label: 'Task Title',
                  onChange: (text) {
                    arg.title = text;
                  },
                  intialValue: arg.title,
                ),
                const Spacer(flex: 2),
                EditTextFormField(
                  label: 'Task Description',
                  onChange: (text) {
                    arg.description = text;
                  },
                  intialValue: arg.description,
                ),
                const Spacer(flex: 2),
                ElevatedButton(
                    onPressed: () {
                      FirebaseUtils.updateTask(
                          arg, authProvider.currentUser!.id!);
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(10)),
                        backgroundColor: MaterialStateProperty.all(
                            appProvider.appTheme == ThemeMode.light
                                ? Theme.of(context).primaryColor
                                : MyTheme.darkPrimaryColor)),
                    child: Text(
                      'Save Changes',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                    )),
                const Spacer(
                  flex: 4,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
