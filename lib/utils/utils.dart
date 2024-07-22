import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:motivated_admin/theme/theme_data.dart';

class Utils {
    static void fieldFocusChange(BuildContext context , FocusNode current , FocusNode nextFocus){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
 static showMessage(
      {required BuildContext context,
      required String title,
      required String message}) {
    Flushbar(backgroundColor: AppTheme.hintColor,titleColor: AppTheme.primaryTextColor,messageColor: AppTheme.primaryColor,
      title: title,
      message: message,
      duration: const Duration(seconds: 3),
    ).show(context);
  }
}
