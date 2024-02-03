import 'package:flutter/material.dart';
import 'package:todo_app/Authentication/CustomTextFormField.dart';
import 'package:todo_app/Authentication/Login/LoginScreen.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName='register';
  var userNameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var confirmPasswordController=TextEditingController();
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
  void register(){
    if(formKey.currentState!.validate()== true){
      // register to firebase auth
    }
  }
}
