import 'package:flutter/material.dart';
import 'package:todo_app/Home/Settings/SettingsTab.dart';
import 'package:todo_app/Home/ToDoList/AddTaskBottomSheet.dart';
import 'package:todo_app/Home/ToDoList/ToDoListTab.dart';

class HomeScreen extends StatefulWidget {
static const String routeName='home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget>tabs=[ToDoListTab(),SettingsTab()];
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('ToDo List')),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6,
          child: BottomNavigationBar(
            onTap: (index){
              setState(() {
                selectedIndex=index;
              });
            },
            currentIndex:selectedIndex ,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.list,),label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.settings_outlined),label: ''),
            ],
          ),
        ),
        floatingActionButton:FloatingActionButton(
          shape: const StadiumBorder(
            side: BorderSide(
              width: 4,
              color: Colors.white
            )
          ),
            onPressed: showAddTaskBottomSheet,
        child: const Icon(Icons.add),),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body:tabs[selectedIndex] ,
      ),
    );
  }
  void showAddTaskBottomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (context)=>const AddTaskBottomSheet());
  }
}
