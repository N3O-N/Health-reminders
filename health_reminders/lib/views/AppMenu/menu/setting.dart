import 'package:flutter/material.dart';
import 'package:health_reminders/controller/operator.dart';
import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/text.dart';
import 'package:health_reminders/views/AppMenu/menu/account_setting.dart';
import 'package:health_reminders/views/AppMenu/menu/appinformation.dart';
import 'package:page_transition/page_transition.dart';

class settingPage extends StatelessWidget {
  final String userId;

  const settingPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: white,
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              'การตั้งค่า',
              style: TextStyle(
                color: Colors
                    .brown, // Assuming 'brown' is a defined color variable
                fontFamily: 'Garuda',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  'บัญชี',
                  style: TextStyles.common,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 5), // ปรับขนาดของปุ่มตามต้องการ
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // ให้มีมุมโค้ง
                      ),
                      //elevation: 5, // เพิ่มเงา
                      foregroundColor: Colors.white, // สีพื้นหลังของปุ่ม
                    ),
                    onPressed: () {
                      // Handle the first button press
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: account_settingPage(
                            userId: userId,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ข้อมูลบัญชี',
                            style: TextStyles.common5,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 24,
                            color: const Color.fromARGB(255, 182, 182, 182),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: 60,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5), // ปรับขนาดของปุ่มตามต้องการ
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // ให้มีมุมโค้ง
                        ),
                        //elevation: 5, // เพิ่มเงา
                        foregroundColor: Colors.white, // สีพื้นหลังของปุ่ม
                      ),
                      onPressed: () {
                        // Handle the first button press
                        print('go to drug notification');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'รหัสผ่าน',
                              style: TextStyles.common5,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 24,
                              color: const Color.fromARGB(255, 182, 182, 182),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  'การแจ้งเตือน',
                  style: TextStyles.common,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: 60,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5), // ปรับขนาดของปุ่มตามต้องการ
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // ให้มีมุมโค้ง
                        ),
                        //elevation: 5, // เพิ่มเงา
                        foregroundColor: Colors.white, // สีพื้นหลังของปุ่ม
                      ),
                      onPressed: () {
                        // Handle the first button press
                        print('go to drug notification');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'เสียง',
                              style: TextStyles.common5,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 24,
                              color: const Color.fromARGB(255, 182, 182, 182),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: 60,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5), // ปรับขนาดของปุ่มตามต้องการ
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // ให้มีมุมโค้ง
                        ),
                        //elevation: 5, // เพิ่มเงา
                        foregroundColor: Colors.white, // สีพื้นหลังของปุ่ม
                      ),
                      onPressed: () {
                        // Handle the first button press
                        print('go to drug notification');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ข่าวสารของระบบ',
                              style: TextStyles.common5,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 24,
                              color: const Color.fromARGB(255, 182, 182, 182),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  'อื่น ๆ',
                  style: TextStyles.common,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: 60,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5), // ปรับขนาดของปุ่มตามต้องการ
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // ให้มีมุมโค้ง
                        ),
                        //elevation: 5, // เพิ่มเงา
                        foregroundColor: Colors.white, // สีพื้นหลังของปุ่ม
                      ),
                      onPressed: () {
                        // Handle the first button press
                        print('go to drug notification');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'นโยบายความเป็นส่วนตัว',
                              style: TextStyles.common5,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 24,
                              color: const Color.fromARGB(255, 182, 182, 182),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: 60,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5), // ปรับขนาดของปุ่มตามต้องการ
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // ให้มีมุมโค้ง
                        ),
                        //elevation: 5, // เพิ่มเงา
                        foregroundColor: Colors.white, // สีพื้นหลังของปุ่ม
                      ),
                      onPressed: () {
                        Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: appinformationPage()
                        ),
                      );
                        // Handle the first button press
                        print('go to information');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ข้อมูลเกี่ยวกับแอปพลิเคชัน',
                              style: TextStyles.common5,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 24,
                              color: const Color.fromARGB(255, 182, 182, 182),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
          
          SizedBox(
            height: 5,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: 60,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5), // ปรับขนาดของปุ่มตามต้องการ
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // ให้มีมุมโค้ง
                        ),
                        //elevation: 5, // เพิ่มเงา
                        foregroundColor: Colors.white, // สีพื้นหลังของปุ่ม
                      ),
                      onPressed: () {
                        // Handle the first button press
                        print('go to drug notification');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ช่วยเหลือ',
                              style: TextStyles.common5,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 24,
                              color: const Color.fromARGB(255, 182, 182, 182),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: buttonlgin,
            onPressed: () {
              UserOperator.logOut(context);
              print('ออกจากระบบ');
            },
            child: Text('ออกจากระบบ', style: TextStyles.Tlogin),
          ),
        ],
      ),
    );
  }
}
