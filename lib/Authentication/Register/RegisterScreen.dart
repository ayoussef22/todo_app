import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Authentication/components/CustomTextFormField.dart';
import 'package:todo_app/Authentication/Login/LoginScreen.dart';
import 'package:todo_app/Utils/DialogUtils.dart';
import 'package:todo_app/Utils/FirebaseUtils.dart';
import 'package:todo_app/Home/HomeScreen.dart';
import 'package:todo_app/Models/MyUser.dart';
import 'package:todo_app/Providers/userAuthProvider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName='register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var userNameController=TextEditingController(text: 'abdallah adel');

  var emailController=TextEditingController(text: 'abdallahadel@yaho.com');

  var passwordController=TextEditingController(text: '123456');

  var confirmPasswordController=TextEditingController(text: '123456');

  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                          label: 'User Name',
                          textFormFieldIcon: Icon(Icons.account_circle),
                          textController: userNameController,
                          validation: (text){
                            if(text==null || text.trim().isEmpty){
                              return ' Please Enter Your Name';
                            }
                            return null;
                          },
                        ),
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
                        CustomTextFormField(
                          label: 'Confirm Password',
                          keyboardType: TextInputType.number,
                          textFormFieldIcon: Icon(Icons.remove_red_eye),
                          textController: confirmPasswordController,
                          obscureText: true,
                          validation: (text){
                            if(text==null || text.trim().isEmpty){
                              return ' Please Enter Your Confirm Password';
                            }
                            if(text != passwordController.text){
                              return 'Your Password Does Not Match';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child:
                          ElevatedButton(onPressed: register,
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                )),
                                padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                                backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
                              child: Text('Register',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white
                              ),)
                          ),
                        ),
                        TextButton(
                            onPressed: (){
                              Navigator.of(context).pushNamed(LoginScreen.routeName);
                            },
                            child: const Text('Already Have An Account',
                                   style:  TextStyle(fontSize: 17),))
                      ],
                    ),
                  )),
            )
          ],
        )
      ),
    );

  }

  void register() async{
    if(formKey.currentState!.validate()== true){
      // register to firebase auth
      //todo: show loading
      DialogUtils.showLoading(context);
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser=MyUser(
            id: credential.user?.uid,
            name: userNameController.text,
            email: emailController.text);
        await FirebaseUtils.addUserToFireStore(myUser);
        var provider=Provider.of<userAuthProvider>(context,listen: false);
        provider.changeUser(myUser);
        //todo: hide loading
        DialogUtils.hideLoading(context);
        //todo: show success message
        DialogUtils.showMessage(context,'register successfully',
            posActionName: 'ok',title: 'Success',
            posAction: (){
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            }
        );
        print(credential.user?.uid);
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideLoading(context);
        if (e.code == 'weak-password') {
          //todo: show error message
          DialogUtils.showMessage(context, 'The password provided is too weak.',title: 'Error',posActionName: 'ok');
        } else if (e.code == 'email-already-in-use') {
          //todo: show error message
          DialogUtils.showMessage(context,
            'The account already exists for that email.',posActionName: 'ok',title: 'Error');
        }
      } catch (e) {
        //todo: hide loading
        DialogUtils.hideLoading(context);
        //todo: show error message
        DialogUtils.showMessage(context, e.toString());
        print(e);
      }
    }
  }
}
