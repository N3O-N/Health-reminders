import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:health_reminders/controller/operator.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/text.dart';
import 'package:page_transition/page_transition.dart';

class NavigationPlugin {
  static void goToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: page,
      ),
    );
  }
}

class SessionManagerPlugin {
  static bool isLoggedIn = false;
}

class showDataPlugin extends StatelessWidget {
  final String docId;
  final Widget Function(
      BuildContext context, dynamic usersData, dynamic healthData) otherClass;

  const showDataPlugin({required this.docId, required this.otherClass});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('users').doc(docId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
        }

        var usersData = snapshot.data!.data();

        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(docId)
              .collection('health_data')
              .doc(docId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return Text('ไม่พบข้อมูล');
            }

            var healthData = snapshot.data!.data();

            return otherClass(context, usersData, healthData);
          },
        );
      },
    );
  }
}

class homeProfileWidget extends StatelessWidget {
  final dynamic usersDataSet;
  final dynamic healthDataSet;

  homeProfileWidget({required this.usersDataSet, required this.healthDataSet});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 255, 112, 67),
              offset: const Offset(0, 0),
              //blurRadius: 20,
              //spreadRadius: -5,
            ),
          ],
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 253, 248, 236),
                Color.fromARGB(255, 249, 242, 227),
                Color.fromARGB(255, 244, 233, 206),
                Color.fromARGB(255, 244, 233, 206),
              ],
              stops: const [
                0.1,
                0.3,
                0.9,
                1.0
              ])),
      child: Column(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: CircleAvatar(
                    backgroundColor: healthDataSet != null &&
                            healthDataSet.containsKey('image_flie')
                        ? null
                        : yellow, // กำหนดสีพื้นหลังเป็นสีเหลืองเมื่อไม่มีรูป
                    backgroundImage: healthDataSet != null &&
                            healthDataSet.containsKey('image_flie')
                        ? NetworkImage(healthDataSet['image_flie'])
                        : null, // กำหนดรูปภาพเมื่อมีข้อมูล
                    radius: 50,
                  ),
                ),
                SizedBox(width: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        '${usersDataSet != null ? usersDataSet['username'] : 'ไม่มีข้อมูล'}',
                        style: TextStyles.common,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'อายุ: ${healthDataSet != null ? '${healthDataSet['age']}  ปี' : 'ไม่มีข้อมูล'}',
                          style: TextStyles.common,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'เพศ: ${healthDataSet != null ? (healthDataSet['gender'] == 'M' ? 'ชาย' : 'หญิง') : 'ไม่มีข้อมูล'}',
                          style: TextStyles.common,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(
            height: 20,
          ),

          //menu bmi
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 80,
                    width: 330, // Set the desired height
                    decoration: BoxDecoration(
                      //border: Border.all(color: brown, width: 1.0),
                      boxShadow: [
                        BoxShadow(
                          color: bb,
                          // blurRadius:5.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('น้ำหนัก', style: TextStyles.Thome),
                        Text(
                            '${healthDataSet != null ? healthDataSet['weight'] : 'ไม่มีข้อมูล'}',
                            style: TextStyles.Thome1),
                        Text('กก.', style: TextStyles.Thome),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    height: 80,
                    width: 330, // Set the desired height
                    decoration: BoxDecoration(
                      //border: Border.all(color: brown, width: 1.0),
                      boxShadow: [
                        BoxShadow(
                          color: bb,
                          // blurRadius:5.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('ส่วนสูง', style: TextStyles.Thome),
                        Text(
                            '${healthDataSet != null ? healthDataSet['height'] : 'ไม่มีข้อมูล'}',
                            style: TextStyles.Thome1),
                        Text('ซม.', style: TextStyles.Thome),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    height: 80,
                    width: 330, // Set the desired height
                    decoration: BoxDecoration(
                      //border: Border.all(color: brown, width: 1.0),
                      boxShadow: [
                        BoxShadow(
                          color: calBMI(healthDataSet['weight'],
                                          healthDataSet['height']) <
                                      18.50 ||
                                  calBMI(healthDataSet['weight'],
                                          healthDataSet['height']) >=
                                      30.00
                              ? Colors.red
                              : (calBMI(healthDataSet['weight'],
                                              healthDataSet['height']) >=
                                          18.50 &&
                                      calBMI(healthDataSet['weight'],
                                              healthDataSet['height']) <=
                                          22.90
                                  ? gg
                                  : (calBMI(healthDataSet['weight'],
                                                  healthDataSet['height']) >=
                                              23.00 &&
                                          calBMI(healthDataSet['weight'],
                                                  healthDataSet['height']) <=
                                              29.90
                                      ? yellow
                                      : yellow)),
                          // blurRadius:5.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('BMI', style: TextStyles.Thome),
                        Text(
                            '${calBMI(healthDataSet['weight'], healthDataSet['height'])}',
                            style: TextStyles.Thome),
                        Text(
                            getBMIString(calBMI(healthDataSet['weight'],
                                healthDataSet['height'])),
                            style: TextStyles.Thome),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // แสดงข้อมูลอื่น ๆ ตามต้องการ
        ],
      ),
    );
  }
}

class profileWidget extends StatelessWidget {
  final dynamic usersDataSet;
  final dynamic healthDataSet;

  profileWidget({required this.usersDataSet, required this.healthDataSet});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 64,
                backgroundColor: healthDataSet != null &&
                        healthDataSet.containsKey('image_flie')
                    ? null
                    : Colors.yellow, // กำหนดสีพื้นหลังเป็นสีเหลืองเมื่อไม่มีรูป
                backgroundImage: healthDataSet != null &&
                        healthDataSet.containsKey('image_flie')
                    ? NetworkImage(healthDataSet['image_flie'])
                    : null, // กำหนดรูปภาพเมื่อมีข้อมูล
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Text(
                'ข้อมูลส่วนตัว',
                style: TextStyles.Tlogin,
              ),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          _buildInfoRow(
            'ชื่อ',
            '${usersDataSet != null ? usersDataSet['username'] : 'ไม่มีข้อมูล'}',
          ),
          _buildInfoRow('อายุ',
              '${healthDataSet != null ? '${healthDataSet['age']} ปี' : 'ไม่มีข้อมูล'}'),
          _buildInfoRow(
            'เพศ',
            '${healthDataSet != null ? (healthDataSet['gender'] == 'M' ? 'ชาย' : 'หญิง') : 'ไม่มีข้อมูล'}',
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Text(
                'ข้อมูลสุขภาพ',
                style: TextStyles.Tlogin,
              ),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          _buildHealthInfoRow('น้ำหนัก',
              '${healthDataSet != null ? '${healthDataSet['weight']} กิโลกรัม' : 'ไม่มีข้อมูล'}'),
          _buildHealthInfoRow('ส่วนสูง',
              '${healthDataSet != null ? '${healthDataSet['height']} เซนติเมตร' : 'ไม่มีข้อมูล'}'),
          _buildHealthInfoRow(
            'BMI   ',
            '${calBMI(healthDataSet['weight'], healthDataSet['height']) < 18.50 ? '${calBMI(healthDataSet['weight'], healthDataSet['height'])}   ผอม' : '${calBMI(healthDataSet['weight'], healthDataSet['height']) >= 18.50 && calBMI(healthDataSet['weight'], healthDataSet['height']) <= 22.90 ? '${calBMI(healthDataSet['weight'], healthDataSet['height'])}   ปกติ' : '${calBMI(healthDataSet['weight'], healthDataSet['height']) >= 23.00 && calBMI(healthDataSet['weight'], healthDataSet['height']) <= 24.90 ? '${calBMI(healthDataSet['weight'], healthDataSet['height'])}   ท้วม' : '${calBMI(healthDataSet['weight'], healthDataSet['height']) >= 25.00 && calBMI(healthDataSet['weight'], healthDataSet['height']) <= 29.90 ? '${calBMI(healthDataSet['weight'], healthDataSet['height'])}   อ้วน' : '${calBMI(healthDataSet['weight'], healthDataSet['height']) >= 30.00 ? '${calBMI(healthDataSet['weight'], healthDataSet['height'])}   อ้วนมาก' : 'ไม่มีข้อมูล'}'}'}'}'}',
          ),
          _buildHealthInfoRow('BMR  ',
              '${healthDataSet != null ? '${healthDataSet['height']} เซนติเมตร' : 'ไม่มีข้อมูล'}'),
        ],
      ),
    );
  }
}

Widget _buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(left: 35, top: 10),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyles.Tlogin,
        ),
        SizedBox(
          width: 50, // ปรับขนาดตามความต้องการ
        ),
        Text(
          value,
          style: TextStyles.common5,
        ),
      ],
    ),
  );
}

Widget _buildHealthInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(left: 35, top: 10),
    child: Row(
      children: [
        Column(
          children: [
            Text(
              label,
              style: TextStyles.Tlogin,
            ),
          ],
        ),
        SizedBox(
          width: 60, // ปรับขนาดตามความต้องการ
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyles.common5,
            ),
          ],
        ),
      ],
    ),
  );
}

class DateButtom extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback onClicked;
  DateButtom(
      {required this.title, required this.text, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0),
        fixedSize: MaterialStateProperty.all<Size>(Size(100, 46)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: brown), // เปลี่ยนสีขอบของปุ่ม
          ),
        ),
        backgroundColor:
            MaterialStateProperty.all<Color>(white), // เปลี่ยนสีพื้นหลังของปุ่ม
      ),
      onPressed: onClicked,
      child: FittedBox(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.brown,
            fontSize: 16,
            fontFamily: 'Garuda',
          ),
        ),
      ),
    );
  }
}

/*class NotificationService {
  final BuildContext context;

  NotificationService(this.context);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotification(DateTime? selectedDate, TimeOfDay? selectedTime) async {
    if (selectedDate != null && selectedTime != null) {
      final DateTime scheduledDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      final AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
      );

      final NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.schedule(
        0,
        'Notification Title',
        'Notification Body',
        scheduledDate,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Scheduled notification at $scheduledDate'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select date and time first'),
        ),
      );
    }
  }
}*/

double calBMI(double w, double h) {
  double bmi = w / ((h / 100) * (h / 100));
  return double.parse(bmi.toStringAsFixed(2));
}

String getBMIString(double bmi) {
  return '${bmi < 18.50 ? 'ผอม' : '${bmi >= 18.50 && bmi <= 22.90 ? 'ปกติ' : '${bmi >= 23.00 && bmi <= 24.90 ? 'ท้วม' : '${bmi >= 25.00 && bmi <= 29.90 ? 'อ้วน' : '${bmi >= 30.00 ? 'อ้วนมาก' : 'ไม่มีข้อมูล'}'}'}'}'}';
}
