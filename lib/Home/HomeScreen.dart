import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Authentication/Login/LoginScreen.dart';
import 'package:todo_app/Home/Settings/SettingsTab.dart';
import 'package:todo_app/Home/ToDoList/AddTaskBottomSheet.dart';
import 'package:todo_app/Home/ToDoList/ToDoListTab.dart';
import 'package:todo_app/Providers/ListProvider.dart';
import 'package:todo_app/Providers/userAuthProvider.dart';

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
    var authProvider=Provider.of<userAuthProvider>(context);
    var listProvider=Provider.of<ListProvider>(context);


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title:Text('ToDo List ${authProvider.currentUser?.name}'),
            actions: [
              IconButton(
                  onPressed: (){
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                listProvider.selectDay=DateTime.now();
                  },
                  icon: Icon(Icons.login_outlined))
            ],
          automaticallyImplyLeading: false,

        ),
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
