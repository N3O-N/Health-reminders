import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

//flutter_lib
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
//firebase_lib
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:health_reminders/controller/plugin.dart';
//views
import 'package:health_reminders/views/Home/home.dart';
//page_transittion_lib
import 'package:page_transition/page_transition.dart';

//import_model
import 'package:health_reminders/model/mode.dart';

class APIEndpoint {
  static Future<bool> signIn(
      BuildContext context, String email, String password) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user != null) {
        // ดึงข้อมูลผู้ใช้จาก Firestore
        QuerySnapshot userQuery = await _firestore
            .collection('users')
            .where('email', isEqualTo: email)
            .get();

        if (userQuery.docs.isNotEmpty) {
          // ครีนี้คือครีของเจ้าของอีเมลนี้
          String userId = userQuery.docs.first['userId'];
          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: homePage(
                userId: userId,
              ),
            ),
          );
          return true;
        }
        return false;
      }
      return false;
    } catch (e) {
      print('signIn Err: $e');
      String errorMessage = 'เข้าสู่ระบบล้มเหลว';

      if (e is FirebaseAuthException) {
        if (e.code == 'invalid-email') {
          errorMessage = 'อีเมลไม่ถูกต้อง';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'รหัสผ่านไม่ถูกต้อง';
        } else if (e.code == 'user-not-found') {
          errorMessage = 'ไม่พบผู้ใช้งานนี้ในระบบ';
        } else {
          errorMessage =
              'อีเมล หรือ รหัสผ่านของท่านไม่ถูกต้อง กรุณาตรวจสอบใหม่อีกครั้ง';
        }
      }

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('แจ้งเตือน'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('ตกลง'),
              ),
            ],
          );
        },
      );
      return false;
    }
  }

  static Future<bool?> signUp(
      BuildContext context, String email, String password) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      return true;
    } on Exception catch (e) {
      // TODO
      print("signUp Err : $e");
      return null;
    }
  }

  static Future<String> uploadImageToFirebase(File? imageFile) async {
    if (imageFile == null) {
      return ''; // หรือสิ่งที่คุณต้องการในกรณีที่ไม่มีภาพ
    }

    try {
      // กำหนด path ใน Firebase Storage ที่ต้องการเก็บรูปภาพ
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('userImage/$fileName');

      // Upload รูปภาพไปยัง Firebase Storage
      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile!);

      // เมื่อ Upload เสร็จสิ้น
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      // รับ URL ของรูปภาพที่ Upload เสร็จสิ้น
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      // หรือส่ง URL กลับไปให้ตัวแอปแสดงผล
      return imageUrl;
    } catch (e) {
      print(e);
      // หรือทำการ handle error ตามต้องการ
      return 'error';
    }
  }

  static Future<String> uploadImageFood(Uint8List _fileBytes) async {
    if (_fileBytes == null) return '';

    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final filePath = 'foods/$fileName.png';

      await FirebaseStorage.instance.ref(filePath).putData(_fileBytes);

      return filePath;
    } catch (error) {
      print('Error uploading image: $error');
      return '';
    }
  }

  static Future<String> uploadImageNews(Uint8List _fileBytes) async {
    if (_fileBytes == null) return '';

    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final filePath = 'news/$fileName.png';

      await FirebaseStorage.instance.ref(filePath).putData(_fileBytes);

      return filePath;
    } catch (error) {
      print('Error uploading image: $error');
      return '';
    }
  }

  static Future<bool> addUser(String uid, String email, String password) async {
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set({'email': email, 'password': password, 'username': ''});

      return true;
    } on Exception catch (e) {
      // TODO
      print("Error: $e");
      return false;
    }
  }

  static Future<bool> addInfo(
      UserModel user, HealthDataModel healthData) async {
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Add user basic info
      await users
          .doc(user.userId)
          .update({'userId': user.userId, 'username': user.username});

      // Add user health data
      await users
          .doc(user.userId)
          .collection('health_data')
          .doc(user.userId)
          .set(healthData.toMap());

      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  static Future<bool> updateInfo(
      String userId, String username, HealthDataModel healthData) async {
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      // Add user health data
      await users.doc(userId).update({'username': username});

      await users
          .doc(userId)
          .collection('health_data')
          .doc(userId)
          .update(healthData.toMap());

      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  static Future<bool> addNoti(String userId, NotiModel noti) async {
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Add user health data
      await users
          .doc(userId)
          .collection('Notification')
          .doc(noti.notiId)
          .set(noti.toMap());

      NotificationServices.scheduleNotification(noti: noti, userId: userId);

      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  static Future<bool> addUserFood(
      String userId, foodDataModel food, String timestamp) async {
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      await users.doc(userId).collection('userFood').doc(food.foodId).set(
        {
          ...food.toMap(),
          'timestamp': timestamp,
          'Status': 'pick',
          'Type': 'food'
        },
      );

      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  static Future<bool> deleteDate(String Id, String label) async {
    try {
      final CollectionReference collectionRef =
          FirebaseFirestore.instance.collection(label);

      await collectionRef.doc(Id).delete();

      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  static Future<bool> updateUserFoodAndWaterStatus(
      String userId, String Id, String newStatus) async {
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      await users
          .doc(userId)
          .collection('userFood')
          .doc(Id)
          .update({'Status': newStatus});

      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  static Future<bool> addUserWater(
      String userId, waterModel water, String timestamp) async {
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      await users.doc(userId).collection('userFood').doc(water.waterId).set(
        {
          ...water.toMap(),
          'timestamp': timestamp,
          'Status': 'pick',
          'Type': 'water'
        },
      );

      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  static Future<bool> updateUserWaterStatus(
      String userId, String waterId, String newStatus) async {
    try {
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      await users
          .doc(userId)
          .collection('userFood')
          .doc(waterId)
          .update({'Status': newStatus});

      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  static Future<bool> addFoodData(foodDataModel foodData) async {
    try {
      final CollectionReference foods =
          FirebaseFirestore.instance.collection('foods');
      await foods.doc(foodData.foodId).set(foodData.toMap());
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  static Future<bool> addNewsData(NewsDataModel newsDataModel) async {
    try {
      final CollectionReference foods =
          FirebaseFirestore.instance.collection('news');
      await foods.doc(newsDataModel.newsId).set(newsDataModel.toMap());
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  static Future<double> fetchTotalNutrientForUserToday(
      String userId, String nutrient) async {
    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(now);

      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      final QuerySnapshot userFoodSnapshot = await users
          .doc(userId)
          .collection('userFood')
          .where('timestamp', isEqualTo: formattedDate)
          .where('Status', isEqualTo: 'pick')
          .get();

      double total = 0;

      for (QueryDocumentSnapshot doc in userFoodSnapshot.docs) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        final double temp = data[nutrient] ?? 0;
        total += temp;
      }

      return total;
    } catch (e) {
      print('Error fetching total calorie for user today: $e');
      return 0;
    }
  }

  static Future<List<double>> fetchTotalNutrientForWeek(String userId,
      String nutrient, int year, int month, int currentDay) async {
    try {
      List<double> dailyNutrients = [];

      // หาวันแรกของสัปดาห์
      DateTime firstDayOfWeek =
          DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
      int lastDayOfWeek = firstDayOfWeek.add(Duration(days: 6)).day;

      for (int day = firstDayOfWeek.day; day <= lastDayOfWeek; day++) {
        DateTime date = DateTime(year, month, day);
        String formattedDate = DateFormat('yyyy-MM-dd').format(date);

        final CollectionReference users =
            FirebaseFirestore.instance.collection('users');

        final QuerySnapshot userFoodSnapshot = await users
            .doc(userId)
            .collection('userFood')
            .where('timestamp', isEqualTo: formattedDate)
            .where('Status', isEqualTo: 'pick')
            .get();

        double totalNutrient = 0;

        for (QueryDocumentSnapshot doc in userFoodSnapshot.docs) {
          final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          final double nutrientValue = data[nutrient] ?? 0;
          totalNutrient += nutrientValue;
        }

        dailyNutrients.add(totalNutrient);
      }

      return dailyNutrients;
    } catch (e) {
      print('Error fetching total $nutrient for user this week: $e');
      return [];
    }
  }

  static Future<void> updateNotificationStatus(
      String userId, String notificationId, String status) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('Notification')
        .doc(notificationId)
        .update({
      'notiStatus': status,
    });
  }

  static Future<int> getUserAge(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('health_data')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        int age = userData['age'];
        return age;
      } else {
        return 0;
      }
    } catch (e) {
      print('Error fetching total calorie for user today: $e');
      return 0;
    }
  }

  static Future<bool> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (e) {
      // TODO
      print("Error: $e");
      return false;
    }
  }
}
