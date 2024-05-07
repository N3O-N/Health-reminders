import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_reminders/styles/color.dart';

class ToastStyles {
  static Future<void> showToastFoodAddToCal(BuildContext context) async {
    FToast fToast = FToast();
    fToast.init(context);
    Widget toast = Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: yellow,
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: brown,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              'เพิ่มเมนูของท่านเสร็จสิ้น',
              style: TextStyle(
                color: brown,
                fontFamily: 'Garuda',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 5),
      gravity: ToastGravity.BOTTOM,
    );
  }
}
