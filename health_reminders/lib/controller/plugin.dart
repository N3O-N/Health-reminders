import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
                          color: gg,
                          // blurRadius:5.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('BMI', style: TextStyles.Thome),
                        Text('22.09', style: TextStyles.Thome1),
                        Text('ปกติ', style: TextStyles.Thome),
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
          _buildHealthInfoRow('BMI   ',
              '${healthDataSet != null ? '${healthDataSet['height']} เซนติเมตร' : 'ไม่มีข้อมูล'}'),
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
