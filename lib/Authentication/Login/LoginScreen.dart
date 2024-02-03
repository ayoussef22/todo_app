import 'package:flutter/material.dart';
import 'package:todo_app/Authentication/CustomTextFormField.dart';
import 'package:todo_app/Authentication/Login/LoginScreen.dart';
import 'package:todo_app/Authentication/Register/RegisterScreen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName='login';
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
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
                                onPressed: register,
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
                              style: Theme.of(context).textTheme.titleMedium,),
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
    );

  }
  void register(){
    if(formKey.currentState!.validate()== true){
      // register to firebase auth
    }
  }
}
