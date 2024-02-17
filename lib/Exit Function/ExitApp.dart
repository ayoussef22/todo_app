import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/Utils/DialogUtils.dart';

class ExitApp {

  static void exitApp(BuildContext context) {
    DialogUtils.showMessage(context, "Are You Sure To Exit ?",
      title: 'Wait !',
      posActionName: 'Yes',
      posAction: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
      negActionName: 'No',
    );
  }
}