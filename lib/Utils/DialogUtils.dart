import 'package:flutter/material.dart';

class DialogUtils{
 static void showLoading(BuildContext context){
   showDialog(
     barrierDismissible: false,
       context: context,
       builder: (context){
     return AlertDialog(
       content: Row(
         children: [
           CircularProgressIndicator(),
           Padding(
             padding: const EdgeInsets.only(left: 13),
             child: Text('Loading ...'),
           )
         ],
       ),
     );
   });
 }
 static void hideLoading(BuildContext context){
   Navigator.pop(context);
 }

 static void showMessage(
     BuildContext context,
     String content,
     {String title='',
      String? posActionName,
       VoidCallback? posAction,
       String? negActionName,
       VoidCallback? negAction
     })async{

   List<Widget>actions=[];

   if(posActionName != null){
     actions.add(TextButton(
         onPressed: (){
           Navigator.pop(context);
           posAction?.call();
         },
         child: Text(posActionName)));
   }
   if(negActionName != null){
     actions.add(TextButton(
         onPressed: (){
           Navigator.pop(context);
           negAction?.call();
         },
         child: Text(negActionName)));
   }
   showDialog(
       barrierDismissible: false,
       context: context,
       builder: (context){
     return AlertDialog(
       title: Text(title),
       titleTextStyle: Theme.of(context).textTheme.titleMedium,
       content: Text(content),
       actions: actions,
     );}
   );
 }

}
