import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Authentication/Login/LoginScreen.dart';
import 'package:todo_app/Exit%20Function/ExitApp.dart';
import 'package:todo_app/Home/Settings/SettingsTab.dart';
import 'package:todo_app/Home/ToDoList/AddTaskBottomSheet.dart';
import 'package:todo_app/Home/ToDoList/ToDoListTab.dart';
import 'package:todo_app/Providers/ListProvider.dart';
import 'package:todo_app/Providers/userAuthProvider.dart';
import 'package:todo_app/Utils/DialogUtils.dart';
import 'package:todo_app/Utils/FirebaseUtils.dart';

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
    return SafeArea(
      child: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop ) {
          if(didPop){
            return;
          }
          ExitApp.exitApp(context);
        },
        child: Scaffold(
          appBar: AppBar(
              title:Text('ToDo List ${authProvider.currentUser?.name} ' ),
              actions: [
                IconButton(
                    onPressed: (){
                  signOut();
                    },
                    icon: const Icon(Icons.login_outlined))
              ],
            automaticallyImplyLeading: false,

          ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 6,
            //color:appProvider.appTheme==ThemeMode.light?Colors.white:
           // Color(0xff85929E ),


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
      ),
    );
  }
  void showAddTaskBottomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (context)=>const AddTaskBottomSheet());
  }

  void signOut(){
    DialogUtils.showMessage(context, 'Are You Sure To SignOut ?',
      title: 'SignOut',
        posActionName: 'Yes',
      posAction: (){
      var authProvider=Provider.of<userAuthProvider>(context,listen: false);
      var listProvider=Provider.of<ListProvider>(context,listen: false);
        FirebaseUtils.userSignOut(authProvider.currentUser!.id!)
            .then((value) {
         Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            listProvider.selectDay=DateTime.now();
            listProvider.tasksList=[];
            authProvider.currentUser=null;}
        );
      },
      negActionName: 'No',

    );
  }
}
