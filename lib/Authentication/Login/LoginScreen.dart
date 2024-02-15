import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Authentication/components/CustomTextFormField.dart';
import 'package:todo_app/Authentication/Register/RegisterScreen.dart';
import 'package:todo_app/Exit%20Function/ExitApp.dart';
import 'package:todo_app/Providers/ListProvider.dart';
import 'package:todo_app/Theming/MyTheme.dart';
import 'package:todo_app/Utils/DialogUtils.dart';
import 'package:todo_app/Utils/FirebaseUtils.dart';
import 'package:todo_app/Home/HomeScreen.dart';
import 'package:todo_app/Providers/userAuthProvider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName='login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController=TextEditingController(text: 'abdallahadel@yaho.com');

  var passwordController=TextEditingController(text: '123456');

  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop)async{
        if(didPop){
          return;
        }
        ExitApp.exitApp(context);
      },
      child: SafeArea(
        child: Scaffold(

            body: Stack(
              children: [
                Image.asset('assets/images/sign_in_bg.png',
                  width: double.infinity,
                  fit: BoxFit.fill,),
                Container(
                  margin: EdgeInsets.only(
                      top: size.height*0.31
                  ),
                  child: Form(
                      key:formKey ,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextFormField(
                              label: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              textFormFieldIcon: Icon(Icons.email),
                              textController: emailController,
                              validation: (text){
                                if(text==null || text.trim().isEmpty){
                                  return ' Please Enter Your Email Address';
                                }
                                bool emailValid =
                                RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(text);
                                if(!emailValid){
                                  return 'Please Enter a Valid Email';
                                }
                                return null;
                              },
                            ),
                            CustomTextFormField
                              (label: 'Password',
                              keyboardType: TextInputType.number,
                              textFormFieldIcon: Icon(Icons.remove_red_eye),
                              textController: passwordController,
                              obscureText: true,
                              validation: (text){
                                if(text==null || text.trim().isEmpty){
                                  return ' Please Enter Your Password';
                                }
                                if(text.length < 6){
                                  return 'Please Enter At least 6 Characters';
                                }
                                return null;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child:
                              ElevatedButton(
                                  onPressed: login,
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                                      backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                      ))
                                  ),
                                  child: Text('Login',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: Colors.white
                                    ),)
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Don’t Have Account ?',
                                style:
                                Theme.of(context).textTheme.titleMedium
                                ),
                                TextButton(
                                    onPressed: (){
                                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                                    },
                                    child: const Text('Sign Up',
                                      style:  TextStyle(fontSize: 17),)),
                              ],
                            )
                          ],
                        ),
                      )),
                )
              ],
            )
        ),
      ),
    );

  }

  void login()async{
    if(formKey.currentState!.validate()== true){
      // login
      //todo: show loading
      DialogUtils.showLoading(context);
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
       var user= await FirebaseUtils.readUserFromFireStore(credential.user!.uid);

        var provider=Provider.of<userAuthProvider>(context,listen: false);
        provider.changeUser(user!);


        //todo: hide loading
        DialogUtils.hideLoading(context);

        //todo: show success message
        DialogUtils.showMessage(context,'login successfully',

          posActionName: 'ok',title: 'Success',
          posAction: (){
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          }
        );


      } on FirebaseAuthException catch (e) {
        print(e);
        DialogUtils.hideLoading(context);
        if (e.code == 'user-not-found') {
          DialogUtils.showMessage(context, 'No User Found For That Email.'
              ,posActionName:'Ok', title: 'Failed Login' );
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          DialogUtils.showMessage(context, 'Wrong Password Provided For That User.'
             ,posActionName:'Ok', title: 'Failed Login' );
        }
      }
    }
  }
}
