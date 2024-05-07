import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:health_reminders/controller/endpoin.dart';
import 'package:health_reminders/controller/operator.dart';
import 'package:health_reminders/model/mode.dart';
import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/text.dart';
import 'package:health_reminders/views/AppMenu/menu/Addmenucal_Page.dart';
import 'package:health_reminders/views/AppMenu/menu/calcalorie.dart';
import 'package:health_reminders/views/AppMenu/menu/food.dart';
import 'package:health_reminders/views/AppMenu/menu/water.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import 'package:url_launcher/url_launcher.dart';

class userPlugin {
  static int createUniqueId() {
    int other = 100; // กำหนดค่า other
    int uniqueId = DateTime.now().microsecond.remainder(other);
    return uniqueId;
  }

  static FutureOr<String> generateId(String collection, String label) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(collection).get();

    List<String> existingUserIds =
        querySnapshot.docs.map((doc) => doc.id).toList();

    int IdNumber = 1;
    String newId;
    do {
      newId = '${label}_id_$IdNumber';
      IdNumber++;
    } while (existingUserIds
        .contains(newId)); // ตรวจสอบว่า user_id ใหม่ซ้ำกับที่มีอยู่หรือไม่

    return newId;
  }

  static FutureOr<String> generateFoodId() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('foods').get();

    List<String> existingFoodIds =
        querySnapshot.docs.map((doc) => doc.id).toList();

    int idNumber = 1;
    String newId;
    do {
      newId = 'food_id_$idNumber';
      idNumber++;
    } while (existingFoodIds.contains(newId));

    return newId;
  }

  static FutureOr<String> generateNewId() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('news').get();

    List<String> existingFoodIds =
        querySnapshot.docs.map((doc) => doc.id).toList();

    int idNumber = 1;
    String newId;
    do {
      newId = 'news_id_$idNumber';
      idNumber++;
    } while (existingFoodIds.contains(newId));

    return newId;
  }

  static FutureOr<String> generateNotiId(String userId) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot =
        await users.doc(userId).collection('Notification').get();

    List<String> existingUserIds =
        querySnapshot.docs.map((doc) => doc.id).toList();

    int userIdNumber = 1;
    String newUserId;
    do {
      newUserId = 'noti_id_$userIdNumber';
      userIdNumber++;
    } while (existingUserIds
        .contains(newUserId)); // ตรวจสอบว่า user_id ใหม่ซ้ำกับที่มีอยู่หรือไม่

    return newUserId;
  }

  static FutureOr<String> generateUserFoodId(String userId) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot =
        await users.doc(userId).collection('userFood').get();

    List<String> existingUserIds =
        querySnapshot.docs.map((doc) => doc.id).toList();

    int userIdNumber = 1;
    String newUserId;
    do {
      newUserId = 'userFood_id_$userIdNumber';
      userIdNumber++;
    } while (existingUserIds
        .contains(newUserId)); // ตรวจสอบว่า user_id ใหม่ซ้ำกับที่มีอยู่หรือไม่

    return newUserId;
  }

  static FutureOr<String> generateUserWaterId(String userId) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot =
        await users.doc(userId).collection('userFood').get();

    List<String> existingUserIds =
        querySnapshot.docs.map((doc) => doc.id).toList();

    int userIdNumber = 1;
    String newUserId;
    do {
      newUserId = 'userWater_id_$userIdNumber';
      userIdNumber++;
    } while (existingUserIds
        .contains(newUserId)); // ตรวจสอบว่า user_id ใหม่ซ้ำกับที่มีอยู่หรือไม่

    return newUserId;
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
          return Center(
            child: SizedBox(
              width: 100,
              height: 5,
              child: Center(
                child: SizedBox(
                  width: 100,
                  height: 5,
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(yellow),
                  ),
                ),
              ),
            ),
          );
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
              return Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(),
                ),
              );
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

class showDataHealthPlugin extends StatelessWidget {
  final String docId;
  final Widget Function(BuildContext context, dynamic healthData) otherClass;
  const showDataHealthPlugin({required this.docId, required this.otherClass});
  @override
  Widget build(BuildContext context) {
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

        return otherClass(context, healthData);
      },
    );
  }
}

class showNewsPlugin extends StatelessWidget {
  final Widget Function(BuildContext context, dynamic newsData) otherClass;
  const showNewsPlugin({required this.otherClass});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('news').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('ไม่พบข้อมูล');
        }

        List<DocumentSnapshot> newsDocuments = snapshot.data!.docs;
        return ListView.builder(
          itemCount: newsDocuments.length,
          itemBuilder: (context, index) {
            dynamic newsData = newsDocuments[index].data();
            return otherClass(context, newsData);
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

class wathercalWidget extends StatelessWidget {
  final dynamic healthDataSet;

  wathercalWidget({required this.healthDataSet});

  @override
  Widget build(BuildContext context) {
    double boxSizeWidth = 345;
    return Container(
      child: Column(
        children: [
          Container(
            height: 70,
            width: boxSizeWidth,
            decoration: BoxDecoration(
              border: Border.all(color: brown, width: 1.0),
              boxShadow: [
                BoxShadow(
                  color: noti,
                  //blurRadius: 5.0,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              children: [
                SizedBox(width: 5),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('ปริมาณน้ำที่ควรได้รับต่อวัน',
                          style: TextStyles.common),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${calWater(healthDataSet['weight'])}',
                        style:
                            TextStyles.common2, // You can customize the style
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'มิลลิลิตร',
                        style: TextStyles.common, // You can customize the style
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class newsWidget extends StatelessWidget {
  final dynamic newsDataSet;

  newsWidget({required this.newsDataSet});

  @override
  Widget build(BuildContext context) {
    double boxSizeWidth = 345;
    return SafeArea(
      child: Expanded(
        child: ListView.builder(
          itemCount: newsDataSet.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> newsData = newsDataSet[index].data();
            return Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: noti,
                    //blurRadius: 5.0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      newsData['image_url'],
                      width: 110,
                      height: 110,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0.0,
                      bottom: 0.0,
                      left: 15.0,
                      right: 0.0,
                    ),
                    child: Container(
                      width: 210.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            newsData['title'],
                            style: TextStyles.Tlogin,
                          ),
                          Text(
                            newsData['content'],
                            style: TextStyles.common2,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('อ่านเพิ่มเติม'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 3.0,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class BMI_Widget extends StatelessWidget {
  final dynamic healthDataSet;

  BMI_Widget({required this.healthDataSet});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: brown,
                width: 1.5,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ค่าดัชนีมวลกาย \n      (BMI)',
                style: TextStyles.Thome,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '${calBMI(healthDataSet['weight'], healthDataSet['height'])}',
                style: TextStyles.Tlogin,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '${calBMI(healthDataSet['weight'], healthDataSet['height']) < 18.50 ? 'ผอม' : '${calBMI(healthDataSet['weight'], healthDataSet['height']) >= 18.50 && calBMI(healthDataSet['weight'], healthDataSet['height']) <= 22.90 ? 'ปกติ' : '${calBMI(healthDataSet['weight'], healthDataSet['height']) >= 23.00 && calBMI(healthDataSet['weight'], healthDataSet['height']) <= 24.90 ? 'ท้วม' : '${calBMI(healthDataSet['weight'], healthDataSet['height']) >= 25.00 && calBMI(healthDataSet['weight'], healthDataSet['height']) <= 29.90 ? 'อ้วน' : '${calBMI(healthDataSet['weight'], healthDataSet['height']) >= 30.00 ? 'อ้วนมาก' : 'ไม่มีข้อมูล'}'}'}'}'}',
                style: TextStyles.Tlogin,
              ),
            ],
          ),
        ],
      ),
    ]));
  }
}

class BMR_Widget extends StatelessWidget {
  final dynamic healthDataSet;

  BMR_Widget({required this.healthDataSet});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 220,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: brown, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'อัตราการเผาพลาญ (BMR)',
                        style: TextStyles.common2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${healthDataSet != null ? '${calBMR(
                            healthDataSet['weight'],
                            healthDataSet['height'],
                            healthDataSet['gender'],
                            healthDataSet['age'],
                          )} กิโลแคลอรี่' : '0.0'}',
                        style: TextStyles.Tlogin,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WeightHeight_Widget extends StatelessWidget {
  final dynamic healthDataSet;

  WeightHeight_Widget({required this.healthDataSet});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Adjust the alignment as needed
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 5.0,
                    left: 30,
                    top: 12.0,
                    bottom: 12.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'น้ำหนัก: ${healthDataSet['weight']}',
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 16,
                          fontFamily: 'Garuda',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 1),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 30.0,
                    left: 5,
                    top: 12.0,
                    bottom: 12.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'ส่วนสูง: ${healthDataSet['height']}',
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 16,
                          fontFamily: 'Garuda',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ExerciseLevel_Widget extends StatelessWidget {
  final dynamic healthDataSet;

  ExerciseLevel_Widget({required this.healthDataSet});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Adjust the alignment as needed
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 30.0,
                    left: 30,
                    top: 12.0,
                    bottom: 12.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'ระดับการออกกำลังกาย: ${healthDataSet['exerciseLevel'] == 0 ? "ระดับที่ 1 \nไม่มีการออกกำลังกาย" : healthDataSet['exerciseLevel'] == 1 ? "ระดับที่ 2 \nออกกำลังกายเล็กน้อยอาทิตย์ละ 1-3 วัน" : healthDataSet['exerciseLevel'] == 2 ? "ระดับที่ 3 \nออกกำลังกายปานกลางอาทิตย์ละ 3-5 วัน" : healthDataSet['exerciseLevel'] == 3 ? "ระดับที่ 4 \nออกกำลังกายอย่างหนักอาทิตย์ละ 6-7 วัน" : healthDataSet['exerciseLevel'] == 4 ? "ระดับที่ 5 \nออกกำลังกายอย่างหนักทุกวัน" : ""}',
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 16,
                          fontFamily: 'Garuda',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SexAge_Widget extends StatelessWidget {
  final dynamic healthDataSet;

  SexAge_Widget({
    required this.healthDataSet,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 5.0,
                    left: 30,
                    top: 12.0,
                    bottom: 12.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'เพศ: ${healthDataSet != null ? (healthDataSet['gender'] == 'M' ? 'ชาย' : 'หญิง') : 'ไม่มีข้อมูล'}',
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 16,
                          fontFamily: 'Garuda',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 1),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 30.0,
                    left: 5,
                    top: 12.0,
                    bottom: 12.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'อายุ: ${healthDataSet['age']} ปี',
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 16,
                          fontFamily: 'Garuda',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
    double userBMR = calBMR(
      healthDataSet['weight'],
      healthDataSet['height'],
      healthDataSet['gender'],
      healthDataSet['age'],
    );
    double TDEE = bmrExercise(userBMR, healthDataSet['exerciseLevel']);

    return Container(
      color: white,
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
          _buildHealthInfoRow(
              'BMR  ',
              '${healthDataSet != null ? '${calBMR(
                  healthDataSet['weight'],
                  healthDataSet['height'],
                  healthDataSet['gender'],
                  healthDataSet['age'],
                )} กิโลแคลอรี่' : 'ไม่มีข้อมูล'}'),
          _buildHealthInfoRow('TDEE ',
              '${healthDataSet != null ? '${TDEE} กิโลแคลอรี่' : 'ไม่มีข้อมูล'}'),
        ],
      ),
    );
  }
}

class summaryCaloriesWidget extends StatelessWidget {
  final dynamic usersDataSet;
  final dynamic healthDataSet;

  summaryCaloriesWidget(
      {required this.usersDataSet, required this.healthDataSet});

  @override
  Widget build(BuildContext context) {
    double boxSizeWidth = 345;

    DateTime currentDate = DateTime.now();

    String formatteDate = DateFormat('dd/MM/yyyy').format(currentDate);

    return SingleChildScrollView(
      child: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'วันที่ $formatteDate',
                          style: TextStyles.Tlogin,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: brown, width: 1.0),
                          boxShadow: [
                            BoxShadow(
                              color: noti,
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('แคลอรี่', style: TextStyles.common),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FutureBuilder<double>(
                                    future: UserOperator.fetchTotalNutrient(
                                        usersDataSet['userId'], 'calorie'),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          '${snapshot.data?.toStringAsFixed(2)}',
                                          style: TextStyles.common2,
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(
                                          'เกิดข้อผิดพลาด',
                                          style: TextStyles.common2,
                                        );
                                      }
                                      return CircularProgressIndicator(); // แสดง Indicator ระหว่างโหลดข้อมูล
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'กิโลแคลอรี่',
                                    style: TextStyles.common,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 75,
                                width: 94,
                                decoration: BoxDecoration(
                                  border: Border.all(color: brown, width: 1.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: noti,
                                      //blurRadius: 5.0,
                                    ),
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('โซเดียม',
                                            style: TextStyles.common2),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FutureBuilder<double>(
                                          future:
                                              UserOperator.fetchTotalNutrient(
                                                  usersDataSet['userId'],
                                                  'sodium'),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Text(
                                                '${snapshot.data?.toStringAsFixed(2)}',
                                                style: TextStyles.common2,
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                'เกิดข้อผิดพลาด',
                                                style: TextStyles.common2,
                                              );
                                            }
                                            return Center(
                                              child: SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ); // แสดง Indicator ระหว่างโหลดข้อมูล
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('กรัม', style: TextStyles.common2),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: Container(
                                height: 75,
                                width: 94,
                                decoration: BoxDecoration(
                                  border: Border.all(color: brown, width: 1.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: noti,
                                      //blurRadius: 5.0,
                                    ),
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Column(
                                  children: [
                                    Row(children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('น้ำตาล', style: TextStyles.common2),
                                    ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FutureBuilder<double>(
                                            future:
                                                UserOperator.fetchTotalNutrient(
                                                    usersDataSet['userId'],
                                                    'suger'),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                  '${snapshot.data?.toStringAsFixed(2)}',
                                                  style: TextStyles.common2,
                                                );
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                  'เกิดข้อผิดพลาด',
                                                  style: TextStyles.common2,
                                                );
                                              }
                                              return Center(
                                                child: SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              ); // แสดง Indicator ระหว่างโหลดข้อมูล
                                            },
                                          ),
                                        ]),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('กรัม', style: TextStyles.common2),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: Container(
                                height: 75,
                                width: 94,
                                decoration: BoxDecoration(
                                  border: Border.all(color: brown, width: 1.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: noti,
                                      //blurRadius: 5.0,
                                    ),
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('ไขมัน',
                                            style: TextStyles.common2),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FutureBuilder<double>(
                                          future:
                                              UserOperator.fetchTotalNutrient(
                                                  usersDataSet['userId'],
                                                  'fat'),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Text(
                                                '${snapshot.data?.toStringAsFixed(2)}',
                                                style: TextStyles.common2,
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                'เกิดข้อผิดพลาด',
                                                style: TextStyles.common2,
                                              );
                                            }
                                            return Center(
                                              child: SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ); // แสดง Indicator ระหว่างโหลดข้อมูล
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('กรัม', style: TextStyles.common2),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'รายการอาหาร',
                            style: TextStyles.common3,
                            textAlign: TextAlign.end,
                          ),
                          IconButton(
                            icon: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'สร้างเมนู',
                                  style: TextStyles.Tlogin,
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: addmenucalPage(
                                    userId: usersDataSet['userId'],
                                  ),
                                ),
                              );
                            },
                            tooltip: 'สร้างเมนู',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    showDataPlugin(
                      docId: usersDataSet['userId'],
                      otherClass: (context, usersData, healthData) =>
                          BuildUserFoodListView(
                        usersDataSet: usersDataSet,
                        healthDataSet: healthDataSet,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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

double calBMI(double w, double h) {
  double bmi = w / ((h / 100) * (h / 100));
  return double.parse(bmi.toStringAsFixed(2));
}

double calBMR(double w, double h, String gender, int age) {
  double BMR;
  if (gender == 'M') {
    BMR = (66 + (13.7 * w) + (5 * h) - (6.8 * age));
    //BMR = bmrExercise(tempBMR, exerciseLevel);
    return double.parse(BMR.toStringAsFixed(2));
  } else if (gender == 'F') {
    BMR = (665 + (9.6 * w) + (1.8 * h) - (4.7 * age));
    //BMR = bmrExercise(tempBMR, exerciseLevel);
    return double.parse(BMR.toStringAsFixed(2));
  } else {
    return 0;
  }
}

double bmrExercise(double bmr, int exerciseLevel) {
  double bmrDiv;
  if (exerciseLevel == 0) {
    bmrDiv = bmr * 1.2;
    return double.parse(bmrDiv.toStringAsFixed(2));
  } else if (exerciseLevel == 1) {
    bmrDiv = bmr * 1.375;
    return double.parse(bmrDiv.toStringAsFixed(2));
  } else if (exerciseLevel == 2) {
    bmrDiv = bmr * 1.55;
    return double.parse(bmrDiv.toStringAsFixed(2));
  } else if (exerciseLevel == 3) {
    bmrDiv = bmr * 1.7;
    return double.parse(bmrDiv.toStringAsFixed(2));
  } else if (exerciseLevel == 4) {
    bmrDiv = bmr * 1.9;
    return double.parse(bmrDiv.toStringAsFixed(2));
  } else {
    return 0;
  }
}

String getBMIString(double bmi) {
  return '${bmi < 18.50 ? 'ผอม' : '${bmi >= 18.50 && bmi <= 22.90 ? 'ปกติ' : '${bmi >= 23.00 && bmi <= 24.90 ? 'ท้วม' : '${bmi >= 25.00 && bmi <= 29.90 ? 'อ้วน' : '${bmi >= 30.00 ? 'อ้วนมาก' : 'ไม่มีข้อมูล'}'}'}'}'}';
}

double calWater(double w) {
  print(w);
  double water = (w / 2) * (2.2) * (30);
  return double.parse(water.toStringAsFixed(2));
}

class NotificationServices {
  static Future<void> InitializaNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'ex',
            channelName: 'ex',
            channelDescription: 'เวลาออกกำลังกาย',
            defaultColor: yellow,
            locked: true,
            enableLights: true,
            playSound: true),
        NotificationChannel(
          channelKey: 'water_reminder',
          channelName: 'water_reminder',
          channelDescription: 'เวลาทานน้ำ',
          defaultColor: yellow,
          locked: true,
          enableLights: true,
          playSound: true,
        ),
        NotificationChannel(
            channelKey: 'cal_reminder',
            channelName: 'cal_reminder',
            channelDescription: 'เตื่อนแคลอรี่เกิน',
            defaultColor: yellow,
            locked: true,
            enableLights: true,
            playSound: true),
        NotificationChannel(
            channelKey: 'Fat_reminder',
            channelName: 'Fat_reminder',
            channelDescription: 'เตื่อนไขมันเกิน',
            defaultColor: yellow,
            locked: true,
            enableLights: true,
            playSound: true),
        NotificationChannel(
            channelKey: 'Suger_reminder',
            channelName: 'Suger_reminder',
            channelDescription: 'เตื่อนน้ำตาลเกิน',
            defaultColor: yellow,
            locked: true,
            enableLights: true,
            playSound: true),
        NotificationChannel(
            channelKey: 'Sodium_reminder',
            channelName: 'Sodium_reminder',
            channelDescription: 'เตื่อนโซเดียมเกิน',
            defaultColor: yellow,
            locked: true,
            enableLights: true,
            playSound: true),
      ],
    );

    scheduleWaterNotifications();
  }

  static Future<void> cancelNotification(String userId, int notiId) async {
    await AwesomeNotifications().cancel(notiId);
  }

  static Future<void> scheduleRepeatingNotification() async {
    DateTime now = DateTime.now();
    int initialHour = now.hour; // Get the current hour
    int initialMinute = now.minute; // Get the current minute
    int nextTriggerHour =
        (initialHour + 2) % 24; // Calculate the next trigger hour after 2 hours
    int nextTriggerMinute = initialMinute; // Keep the minutes the same

    // Define the notification schedule
    NotificationCalendar(
      hour: nextTriggerHour,
      minute: nextTriggerMinute,
      preciseAlarm: true,
      allowWhileIdle: true,
      timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
    );
  }

  static Future<void> scheduleWaterNotifications() async {
    Random rd = Random();
    final int max = 1000000;

    DateTime now = DateTime.now();
    int initialHour = now.hour; // Get the current hour
    int initialMinute = now.minute; // Get the current minute
    int nextTriggerHour =
        (initialHour + 2) % 24; // Calculate the next trigger hour after 2 hours
    int nextTriggerMinute = initialMinute; // Keep the minutes the same

    // เช็คว่าปัจจุบันอยู่ในช่วงเวลาที่ต้องการหรือไม่ (8 โมงเช้าถึง 9 โมงเย็น)
    if (now.hour >= 8 && now.hour < 21) {
      // สร้างการแจ้งเตือน
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: rd.nextInt(max) + 1,
          channelKey: 'water_reminder',
          title: 'เวลาทานน้ำ',
          body: 'ถึงเวลาทานน้ำแล้ว! โปรดดื่มน้ำให้เพียงพอ',
          category: NotificationCategory.Message,
          notificationLayout: NotificationLayout.BigText,
          locked: true,
          autoDismissible: true,
          fullScreenIntent: true,
          backgroundColor: yellow,
        ),
        actionButtons: [
          NotificationActionButton(
            key: 'close',
            label: 'ปิดการแจ้งเตือน',
            autoDismissible: true,
          ),
        ],
        schedule: NotificationCalendar(
          hour: nextTriggerHour,
          minute: nextTriggerMinute,
          preciseAlarm: true,
          allowWhileIdle: true,
          timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
        ),
      );
    }
  }

  static Future<void> scheduleCalorieExceedingBMRNotification(
      {final bool schedule = false, DateTime? now}) async {
    Random rd = Random();
    final int max = 1000000;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: rd.nextInt(max) + 1,
        channelKey: 'cal_reminder',
        title: 'คำเตือนแคลอรี่',
        body:
            'คุณได้บริโภคแคลอรี่มากกว่าพลังงานที่คุณจะได้รับแล้ว! โปรดระมัดระวังในการบริโภค',
        category: NotificationCategory.Reminder,
        notificationLayout: NotificationLayout.BigText,
        locked: true,
        autoDismissible: false,
        fullScreenIntent: true,
        backgroundColor: yellow,
      ),
      schedule: schedule && now != null
          ? NotificationCalendar(
              second: now.second,
              minute: now.minute,
              hour: now.hour,
              day: now.day,
              month: now.month,
              year: now.year,
            )
          : null,
      actionButtons: [
        NotificationActionButton(
            key: 'close',
            label: 'ปิดการแจ้งเตือน',
            autoDismissible: true,
            isDangerousOption: true)
      ],
    );
  }

  static Future<void> scheduleFatNotification(
      {final bool schedule = false, DateTime? now}) async {
    Random rd = Random();
    final int max = 1000000;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: rd.nextInt(max) + 1,
        channelKey: 'Fat_reminder',
        title: 'คำเตือนการรับประทานไขมัน',
        body:
            'คุณได้บริโภคไขมันเกินความต้องการในแต่ละวันของคุณแล้ว! โปรดระมัดระวังในการบริโภค',
        category: NotificationCategory.Message,
        notificationLayout: NotificationLayout.BigText,
        locked: true,
        autoDismissible: false,
        fullScreenIntent: true,
        backgroundColor: yellow,
      ),
      schedule: schedule && now != null
          ? NotificationCalendar(
              second: now.second,
              minute: now.minute,
              hour: now.hour,
              day: now.day,
              month: now.month,
              year: now.year,
            )
          : null,
      actionButtons: [
        NotificationActionButton(
          key: 'close',
          label: 'ปิดการแจ้งเตือน',
          autoDismissible: true,
        )
      ],
    );
  }

  static Future<void> scheduleSugerNotification(
      {final bool schedule = false, DateTime? now}) async {
    Random rd = Random();
    final int max = 1000000;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: rd.nextInt(max) + 1,
        channelKey: 'Suger_reminder',
        title: 'คำเตือนการรับประทานน้ำตาล',
        body:
            'คุณได้บริโภคน้ำตาลเกินความต้องการในแต่ละวันของคุณแล้ว! โปรดระมัดระวังในการบริโภค',
        category: NotificationCategory.Message,
        notificationLayout: NotificationLayout.BigText,
        locked: true,
        autoDismissible: false,
        fullScreenIntent: true,
        backgroundColor: yellow,
      ),
      schedule: schedule && now != null
          ? NotificationCalendar(
              second: now.second,
              minute: now.minute,
              hour: now.hour,
              day: now.day,
              month: now.month,
              year: now.year,
            )
          : null,
      actionButtons: [
        NotificationActionButton(
          key: 'close',
          label: 'ปิดการแจ้งเตือน',
          autoDismissible: true,
        )
      ],
    );
  }

  static Future<void> scheduleSodiumNotification(
      {final bool schedule = false, DateTime? now}) async {
    Random rd = Random();
    final int max = 1000000;

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: rd.nextInt(max) + 1,
        channelKey: 'Suger_reminder',
        title: 'คำเตือนการรับประทานโซเดียม',
        body:
            'คุณได้บริโภคโซเดียมเกินความต้องการในแต่ละวันของคุณแล้ว! โปรดระมัดระวังในการบริโภค',
        category: NotificationCategory.Reminder,
        notificationLayout: NotificationLayout.BigText,
        locked: true,
        autoDismissible: false,
        fullScreenIntent: true,
        backgroundColor: yellow,
      ),
      schedule: schedule && now != null
          ? NotificationCalendar(
              second: now.second,
              minute: now.minute,
              hour: now.hour,
              day: now.day,
              month: now.month,
              year: now.year,
            )
          : null,
      actionButtons: [
        NotificationActionButton(
          key: 'close',
          label: 'ปิดการแจ้งเตือน',
          autoDismissible: true,
        )
      ],
    );
  }

  static Future<void> scheduleNotification(
      {required NotiModel noti, required String userId}) async {
    Random rd = Random();
    final int max = 1000000;
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: rd.nextInt(max) + 1,
        channelKey: 'ex',
        title: noti.title,
        body: noti.note,
        category: NotificationCategory.Alarm,
        notificationLayout: NotificationLayout.BigText,
        locked: true,
        autoDismissible: false,
        fullScreenIntent: true,
        backgroundColor: yellow,
      ),
      schedule: NotificationCalendar(
        minute: noti.selectedTime.minute,
        hour: noti.selectedTime.hour,
        day: noti.selectedDate.day,
        month: noti.selectedDate.month,
        year: noti.selectedDate.year,
        preciseAlarm: true,
        allowWhileIdle: true,
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'close',
          label: 'ปิดการแจ้งเตือน',
          autoDismissible: true,
        )
      ],
    );

    // คำนวณเวลาที่ต้องรอจนกว่าจะถึงเวลาที่ตั้งการแจ้งเตือน
    DateTime notificationTime = DateTime(
      noti.selectedDate.year,
      noti.selectedDate.month,
      noti.selectedDate.day,
      noti.selectedTime.hour,
      noti.selectedTime.minute,
    );

    // คำนวณเวลาที่เหลือจนกว่าจะถึงเวลาที่ต้องการแจ้งเตือน
    Duration timeUntilNotification =
        notificationTime.difference(DateTime.now());

    // รอจนกว่าจะถึงเวลาที่ตั้งการแจ้งเตือน
    Timer(
      timeUntilNotification,
      () async {
        // เมื่อถึงเวลาที่ตั้งการแจ้งเตือนเอาไว้ จะทำการเรียก API เพื่ออัปเดตสถานะการแจ้งเตือน
        await APIEndpoint.updateNotificationStatus(
            userId, noti.notiId, 'scheduled');
      },
    );
  }
}

class BuildNotificationListView extends StatelessWidget {
  final String userId;
  final String label;

  BuildNotificationListView({required this.userId, required this.label});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('Notification')
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

        var notifications = snapshot.data!.docs;

        return Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              var notification =
                  notifications[index].data() as Map<String, dynamic>;
              if (notification != null &&
                  notification['notiStatus'] == 'active' &&
                  notification['notiStatusLabel'] == label) {
                return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          //Delete
                          UserOperator.updateNotificationStatus(
                              context, userId, notification['notiId']);

                          NotificationServices.cancelNotification(
                              userId, notification['notiId']);
                        },
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 10.0,
                      left: 10.0,
                    ),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: ListTile(
                        title: Text(notification['title'] ?? ''),
                        subtitle: Text(notification['note'] ?? ''),
                      ),
                    ),
                  ),
                );
              } else {
                return Container(); // ถ้าสถานะไม่ใช่ active ให้ไม่แสดงรายการ
              }
            },
          ),
        );
      },
    );
  }
}

class BuildFoodListView extends StatelessWidget {
  final dynamic usersDataSet;
  final dynamic healthDataSet;
  final String label;

  const BuildFoodListView(
      {required this.usersDataSet,
      required this.healthDataSet,
      required this.label});

  @override
  Widget build(BuildContext context) {
    double userBMR, TDEE;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('foods').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SizedBox(
              width: 100,
              height: 5,
              child: Center(
                child: SizedBox(
                  width: 100,
                  height: 5,
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(yellow),
                  ),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Text('ไม่พบข้อมูล');
        }

        var fooddata = snapshot.data!.docs;

        return Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: fooddata.length,
              itemBuilder: (context, index) {
                var foodList = fooddata[index].data() as Map<String, dynamic>;
                if (foodList != null && foodList['labal'] == label) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 10.0,
                      left: 10.0,
                    ),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: FutureBuilder<String>(
                            future: FirebaseStorage.instance
                                .ref('${foodList['image_file']}')
                                .getDownloadURL(),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  return Image.network(
                                    snapshot.data!,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  );
                                } else {
                                  return Icon(Icons
                                      .error); // แสดงไอคอนเมื่อเกิดข้อผิดพลาด
                                }
                              } else {
                                return CircularProgressIndicator(); // แสดง indicator ขณะโหลดรูปภาพ
                              }
                            },
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      foodList['name_food'] ?? 'ไม่มีข้อมูล',
                                      style: TextStyles.Tlogin,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('แคลอรี่ : ${foodList['calorie']}' ??
                                      'ไม่มีข้อมูล'),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('น้ำตาล : ${foodList['suger']}' ??
                                      'ไม่มีข้อมูล'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('ไขมัน : ${foodList['fat']}' ??
                                      'ไม่มีข้อมูล'),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('โซเดียม : ${foodList['sodium']}' ??
                                      'ไม่มีข้อมูล'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: brown,
                          ),
                          onPressed: () async {
                            userBMR = calBMR(
                              healthDataSet['weight'],
                              healthDataSet['height'],
                              healthDataSet['gender'],
                              healthDataSet['age'],
                            );

                            TDEE = bmrExercise(
                                userBMR, healthDataSet['exerciseLevel']);

                            UserOperator.addFoodUser(
                              context,
                              usersDataSet['userId'],
                              foodList['image_file'],
                              foodList['name_food'],
                              double.parse(foodList['calorie'].toString()),
                              double.parse(foodList['fat'].toString()),
                              double.parse(foodList['suger'].toString()),
                              double.parse(foodList['sodium'].toString()),
                              TDEE,
                              label,
                            );
                          },
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(); // ถ้าสถานะไม่ใช่ active ให้ไม่แสดงรายการ
                }
              },
            ),
          ),
        );
      },
    );
  }
}

class BuildListViewForWeb extends StatelessWidget {
  final String label;
  final String type;

  const BuildListViewForWeb(
      {super.key, required this.label, required this.type});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(label).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Text('ไม่พบข้อมูล');
        }

        var fooddata = snapshot.data!.docs;

        return Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: fooddata.length,
              itemBuilder: (context, index) {
                var foodList = fooddata[index].data() as Map<String, dynamic>;
                if (foodList != null && foodList['labal'] == type) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 10.0,
                      left: 10.0,
                    ),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: FutureBuilder<String>(
                            future: FirebaseStorage.instance
                                .ref('${foodList['image_file']}')
                                .getDownloadURL(),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  return Image.network(
                                    snapshot.data!,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  );
                                } else {
                                  return Icon(Icons
                                      .error); // แสดงไอคอนเมื่อเกิดข้อผิดพลาด
                                }
                              } else {
                                return CircularProgressIndicator(); // แสดง indicator ขณะโหลดรูปภาพ
                              }
                            },
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      foodList['name_food'] ?? 'ไม่มีข้อมูล',
                                      style: TextStyles.Tlogin,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('แคลอรี่ : ${foodList['calorie']}' ??
                                      'ไม่มีข้อมูล'),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('น้ำตาล : ${foodList['suger']}' ??
                                      'ไม่มีข้อมูล'),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('ไขมัน : ${foodList['fat']}' ??
                                      'ไม่มีข้อมูล'),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('โซเดียม : ${foodList['sodium']}' ??
                                      'ไม่มีข้อมูล'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: brown,
                          ),
                          onPressed: () async {
                            UserOperator.deleteData(
                              context,
                              foodList['foodId'],
                              label,
                            );
                          },
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(); // ถ้าสถานะไม่ใช่ active ให้ไม่แสดงรายการ
                }
              },
            ),
          ),
        );
      },
    );
  }
}

class BuildUserFoodListView extends StatelessWidget {
  final dynamic usersDataSet;
  final dynamic healthDataSet;

  const BuildUserFoodListView(
      {required this.usersDataSet, required this.healthDataSet});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');

    final Stream<QuerySnapshot> userFoodStream = users
        .doc(usersDataSet['userId'])
        .collection('userFood')
        .where('timestamp', isEqualTo: formattedDate)
        .where('Status', isEqualTo: 'pick')
        .where('Type', isEqualTo: 'food')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: userFoodStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Text('ไม่พบข้อมูล');
        }

        var fooddata = snapshot.data!.docs;

        return Center(
          child: Container(
            height: 500, //MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: fooddata.length,
              itemBuilder: (context, index) {
                var foodList = fooddata[index].data() as Map<String, dynamic>;

                Widget leadingWidget;

                if (foodList['image_file'].startsWith('https://')) {
                  // ถ้าเป็น URL ให้ใช้ URL โดยตรง
                  leadingWidget = Image.network(
                    foodList['image_file'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  );
                } else {
                  // ถ้าไม่ใช่ URL ให้ใช้ Firebase Storage เพื่อดึงรูปภาพ
                  leadingWidget = FutureBuilder<String>(
                    future: FirebaseStorage.instance
                        .ref(foodList['image_file'])
                        .getDownloadURL(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Image.network(
                            snapshot.data!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          );
                        } else {
                          return Icon(
                              Icons.error); // แสดงไอคอนเมื่อเกิดข้อผิดพลาด
                        }
                      } else {
                        return CircularProgressIndicator(); // แสดง indicator ขณะโหลดรูปภาพ
                      }
                    },
                  );
                }
                if (foodList != null) {
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            //Delete
                            UserOperator.updateUserFoodStatus(context,
                                usersDataSet['userId'], foodList['foodId']);
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: calcaloriePage(
                                  userId: usersDataSet['userId'],
                                ),
                              ),
                            );
                          },
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 10.0,
                        left: 10.0,
                      ),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: leadingWidget,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        foodList['name_food'] ?? 'ไม่มีข้อมูล',
                                        style: TextStyles.Tlogin,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('แคลอรี่ : ${foodList['calorie']}' ??
                                        'ไม่มีข้อมูล'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('น้ำตาล : ${foodList['suger']}' ??
                                        'ไม่มีข้อมูล'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('ไขมัน : ${foodList['fat']}' ??
                                        'ไม่มีข้อมูล'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('โซเดียม : ${foodList['sodium']}' ??
                                        'ไม่มีข้อมูล'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(); // ถ้าสถานะไม่ใช่ active ให้ไม่แสดงรายการ
                }
              },
            ),
          ),
        );
      },
    );
  }
}

class BuildUserWaterListView extends StatelessWidget {
  final dynamic usersDataSet;
  final dynamic healthDataSet;

  const BuildUserWaterListView(
      {required this.usersDataSet, required this.healthDataSet});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');

    final Stream<QuerySnapshot> userFoodStream = users
        .doc(usersDataSet['userId'])
        .collection('userFood')
        .where('timestamp', isEqualTo: formattedDate)
        .where('Status', isEqualTo: 'pick')
        .where('Type', isEqualTo: 'water')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: userFoodStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Text('ไม่พบข้อมูล');
        }

        var data = snapshot.data!.docs;

        return Center(
          child: Container(
            height: 500, //MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var List = data[index].data() as Map<String, dynamic>;
                if (List != null) {
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            //Delete
                            UserOperator.updateUserWaterStatus(context,
                                usersDataSet['userId'], List['waterId']);
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: waterPage(
                                  userId: usersDataSet['userId'],
                                ),
                              ),
                            );
                          },
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 10.0,
                        left: 10.0,
                      ),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // จัดการตำแหน่งแกนตั้งให้ตรงกลาง
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'ปริมาณน้ำที่ดื่ม',
                                      style: TextStyles.Tlogin,
                                    ),
                                    Text(
                                      '${List != null ? List['amount'] ?? 'ไม่มีข้อมูล' : 'ไม่มีข้อมูล'}',
                                      style: TextStyles.Tlogin,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(); // ถ้าสถานะไม่ใช่ active ให้ไม่แสดงรายการ
                }
              },
            ),
          ),
        );
      },
    );
  }
}

class BuildNewsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('news').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Text('ไม่พบข้อมูล');
        }

        var newsdata = snapshot.data!.docs;

        return Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.separated(
            separatorBuilder: (context, index) =>
                Divider(color: Colors.grey), // แบ่งแต่ละรายการด้วยเส้นขอบ
            itemCount: newsdata.length,
            itemBuilder: (context, index) {
              var newsList = newsdata[index].data() as Map<String, dynamic>;
              return buildNewsListTile(newsList, _launchURL);
            },
          ),
        );
      },
    );
  }

  Widget buildNewsListTile(
      Map<String, dynamic> newsList, Function(String) launchURL) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 100,
        child: Column(
          children: [
            Expanded(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FutureBuilder<String>(
                    future: FirebaseStorage.instance
                        .ref('${newsList['image_file']}')
                        .getDownloadURL(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Image.network(
                            snapshot.data!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          );
                        } else {
                          return Icon(Icons.error);
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsList['news_name'] ?? 'ไม่มีข้อมูล',
                      style: TextStyles.Tlogin,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      newsList['des'] ?? 'ไม่มีข้อมูล',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        String url = newsList['news_link'];
                        launchUrl(Uri.parse(url),
                            mode: LaunchMode.inAppBrowserView);
                      },
                      child: Text('อ่านเพิ่มเติม'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BuildAmountWaterListView extends StatelessWidget {
  final dynamic usersDataSet;
  final dynamic healthDataSet;

  const BuildAmountWaterListView({
    required this.usersDataSet,
    required this.healthDataSet,
  });

  @override
  Widget build(BuildContext context) {
    double boxSizeWidth = 345;
    return Container(
      child: Column(
        children: [
          Container(
            height: 70,
            width: boxSizeWidth,
            decoration: BoxDecoration(
              border: Border.all(color: brown, width: 1.0),
              boxShadow: [
                BoxShadow(
                  color: noti,
                  //blurRadius: 5.0,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              children: [
                SizedBox(width: 5),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('ปริมาณน้ำที่ได้รับ', style: TextStyles.common),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FutureBuilder<double>(
                        future: UserOperator.fetchTotalNutrient(
                            usersDataSet['userId'], 'amount'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              '${snapshot.data?.toStringAsFixed(2)}',
                              style: TextStyles.common2,
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                              'เกิดข้อผิดพลาด',
                              style: TextStyles.common2,
                            );
                          }
                          return CircularProgressIndicator(); // แสดง Indicator ระหว่างโหลดข้อมูล
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'มิลลิลิตร',
                        style: TextStyles.common, // You can customize the style
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BuildNewsListViewForWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('news').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Text('ไม่พบข้อมูล');
        }

        var newsdata = snapshot.data!.docs;

        return Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.separated(
            separatorBuilder: (context, index) =>
                Divider(color: Colors.grey), // แบ่งแต่ละรายการด้วยเส้นขอบ
            itemCount: newsdata.length,
            itemBuilder: (context, index) {
              var newsList = newsdata[index].data() as Map<String, dynamic>;
              return buildNewsListTile(context, newsList);
            },
          ),
        );
      },
    );
  }

  Widget buildNewsListTile(
    BuildContext context,
    Map<String, dynamic> newsList,
  ) {
    Future<String> _getImageUrl(String imageUrl) async {
      try {
        Reference ref = FirebaseStorage.instance.ref(imageUrl);
        String downloadUrl = await ref.getDownloadURL();
        return downloadUrl;
      } catch (e) {
        print('Error fetching image: $e');
        throw e; // Rethrow the error to be caught by the FutureBuilder
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 100,
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FutureBuilder<String>(
                    future: _getImageUrl(newsList['image_file']),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Show progress indicator during loading
                      } else if (snapshot.hasError) {
                        return Icon(
                            Icons.error); // Show error icon if loading fails
                      } else if (snapshot.hasData) {
                        return Image.network(
                          snapshot.data!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ); // Show image if available
                      } else {
                        return Icon(Icons
                            .error); // Show error icon if no data available
                      }
                    },
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsList['news_name'] ?? 'ไม่มีข้อมูล',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      newsList['des'] ?? 'ไม่มีข้อมูล',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.brown,
                  ),
                  onPressed: () async {
                    UserOperator.deleteData(
                      context,
                      newsList['newsId'],
                      'news',
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
