import 'dart:io';
import 'dart:typed_data';

//flutter_lib
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//endpoin and views
import 'package:health_reminders/controller/endpoin.dart';
import 'package:health_reminders/styles/toast.dart';
import 'package:health_reminders/views/AppMenu/menu/calcalorie.dart';
import 'package:health_reminders/views/AppMenu/notification/showNotiScreen.dart';
import 'package:health_reminders/views/Home/home.dart';
import 'package:health_reminders/views/Intro/gender_screen.dart';
import 'package:health_reminders/controller/plugin.dart';
import 'package:health_reminders/views/Intro/landing_screen.dart';
import 'package:intl/intl.dart';

//page_transittion_lib
import 'package:page_transition/page_transition.dart';

//import_model
import 'package:health_reminders/model/mode.dart';

class UserOperator {
  static Future<bool> login(
      BuildContext context, String email, String password) async {
    final bool success = await APIEndpoint.signIn(context, email, password);
    return success;
  }

  static Future<void> newSignUp(BuildContext context, String email,
      String password, String passwordConf) async {
    try {
      if (password == passwordConf) {
        String userid = await userPlugin.generateId('users', 'user');
        if (userid.isNotEmpty) {
          bool? addSuccess = await APIEndpoint.addUser(userid, email, password);

          if (addSuccess == true) {
            bool? success = await APIEndpoint.signUp(context, email, password);

            if (success == true && addSuccess == true) {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: genderPage(
                    userId: userid,
                    email: email,
                    password: password,
                  ),
                ),
              );
            }
          }
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('แจ้งเตือน'),
              content: Text('รหัสไม่ตรงกัน'),
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
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // หาก email ถูกใช้งานไปแล้ว ให้แสดง Dialog แจ้งเตือน
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('แจ้งเตือน'),
              content: Text('อีเมล์นี้มีการใช้งานไปแล้ว'),
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
      } else {
        // จัดการกับข้อผิดพลาดอื่น ๆ ที่อาจเกิดขึ้น
        print('เกิดข้อผิดพลาด: ${e.message}');
      }
    } catch (e) {
      print('เกิดข้อผิดพลาด: $e');
    }
  }

  static Future<void> addFood(
    BuildContext context,
    Uint8List? imageFile,
    String name_food,
    double calorie,
    double fat,
    double suger,
    double sodium,
    String labal,
  ) async {
    String foodId = await userPlugin.generateFoodId();
    String imageUrl = await APIEndpoint.uploadImageFood(imageFile!);

    foodDataModel foodData = foodDataModel(
      foodId: foodId,
      image_file: imageUrl,
      name_food: name_food,
      calorie: calorie,
      fat: fat,
      suger: suger,
      sodium: sodium,
      labal: labal,
    );

    final success = await APIEndpoint.addFoodData(foodData);

    if (success) {
      Navigator.pop(
        context,
      );
    }
  }

  static Future<void> addFoodUser(
    BuildContext context,
    String userId,
    String imageUrl,
    String name_food,
    double calorie,
    double fat,
    double suger,
    double sodium,
    double userBMR,
    String labal,
  ) async {
    try {
      String foodId = await userPlugin.generateUserFoodId(userId);

      foodDataModel foodData = foodDataModel(
        foodId: foodId,
        image_file: imageUrl,
        name_food: name_food,
        calorie: calorie,
        fat: fat,
        suger: suger,
        sodium: sodium,
        labal: labal,
      );

      DateTime timestamp = DateTime.now();
      String dateOnly = DateFormat('yyyy-MM-dd').format(timestamp);

      final success = await APIEndpoint.addUserFood(userId, foodData, dateOnly);

      if (success) {
        ToastStyles.showToastFoodAddToCal(context);

        double totalCalorie =
            await UserOperator.fetchTotalNutrient(userId, 'calorie');

        print('$totalCalorie');
        double totalFat = await UserOperator.fetchTotalNutrient(userId, 'fat');
        double totalSodium =
            await UserOperator.fetchTotalNutrient(userId, 'sodium');
        double totalSugar =
            await UserOperator.fetchTotalNutrient(userId, 'suger');

        int age = await UserOperator.getUserAge(userId);

        if (age >= 13 && age <= 60) {
          if (totalCalorie >= userBMR) {
            if (totalSugar < 24.0 && totalSodium < 2.3 && totalFat < 24.0) {
              NotificationServices.scheduleCalorieExceedingBMRNotification();
            } else if (totalSugar > 24.0 &&
                totalSodium < 2.3 &&
                totalFat < 24.0) {
              NotificationServices.scheduleSugerNotification();
            } else if (totalSugar < 24.0 &&
                totalSodium > 2.3 &&
                totalFat < 24.0) {
              NotificationServices.scheduleSodiumNotification();
            } else if (totalSugar < 24.0 &&
                totalSodium < 2.3 &&
                totalFat > 24.0) {
              NotificationServices.scheduleFatNotification();
            } else if (totalSugar > 24.0 &&
                totalSodium > 2.3 &&
                totalFat > 24.0) {
              NotificationServices.scheduleCalorieExceedingBMRNotification();
              NotificationServices.scheduleSugerNotification();
              NotificationServices.scheduleSodiumNotification();
              NotificationServices.scheduleFatNotification();
            } else if (totalSugar > 24.0 &&
                totalSodium < 2.3 &&
                totalFat < 24.0) {
              NotificationServices.scheduleCalorieExceedingBMRNotification();
              NotificationServices.scheduleSugerNotification();
            } else if (totalSugar < 24.0 &&
                totalSodium > 2.3 &&
                totalFat < 24.0) {
              NotificationServices.scheduleCalorieExceedingBMRNotification();
              NotificationServices.scheduleSodiumNotification();
            } else if (totalSugar < 24.0 &&
                totalSodium < 2.3 &&
                totalFat > 24.0) {
              NotificationServices.scheduleCalorieExceedingBMRNotification();
              NotificationServices.scheduleFatNotification();
            }
          } else if (totalCalorie < userBMR) {
            if (totalSugar > 24.0 && totalSodium > 2.3 && totalFat < 24.0) {
              NotificationServices.scheduleSugerNotification();
              NotificationServices.scheduleSodiumNotification();
            } else if (totalSugar > 24.0 &&
                totalSodium < 2.3 &&
                totalFat > 24.0) {
              NotificationServices.scheduleSugerNotification();
              NotificationServices.scheduleFatNotification();
            } else if (totalSugar < 24.0 &&
                totalSodium > 2.3 &&
                totalFat > 24.0) {
              NotificationServices.scheduleSodiumNotification();
              NotificationServices.scheduleFatNotification();
            } else if (totalSugar > 24.0 &&
                totalSodium < 2.3 &&
                totalFat < 24.0) {
              NotificationServices.scheduleSugerNotification();
            } else if (totalSugar < 24.0 &&
                totalSodium > 2.3 &&
                totalFat < 24.0) {
              NotificationServices.scheduleSodiumNotification();
            } else if (totalSugar < 24.0 &&
                totalSodium < 2.3 &&
                totalFat > 24.0) {
              NotificationServices.scheduleFatNotification();
            }
          }
        } else {
          if (totalCalorie >= userBMR) {
            if (totalSugar < 24.0 && totalSodium < 2.3 && totalFat < 16.0) {
              NotificationServices.scheduleCalorieExceedingBMRNotification();
            } else if (totalSugar > 24.0 &&
                totalSodium < 2.3 &&
                totalFat < 16.0) {
              NotificationServices.scheduleSugerNotification();
            } else if (totalSugar < 24.0 &&
                totalSodium > 2.3 &&
                totalFat < 16.0) {
              NotificationServices.scheduleSodiumNotification();
            } else if (totalSugar < 24.0 &&
                totalSodium < 2.3 &&
                totalFat > 16.0) {
              NotificationServices.scheduleFatNotification();
            } else if (totalSugar > 24.0 &&
                totalSodium > 2.3 &&
                totalFat > 16.0) {
              NotificationServices.scheduleCalorieExceedingBMRNotification();
              NotificationServices.scheduleSugerNotification();
              NotificationServices.scheduleSodiumNotification();
              NotificationServices.scheduleFatNotification();
            } else if (totalSugar > 24.0 &&
                totalSodium < 2.3 &&
                totalFat < 16.0) {
              NotificationServices.scheduleCalorieExceedingBMRNotification();
              NotificationServices.scheduleSugerNotification();
            } else if (totalSugar < 24.0 &&
                totalSodium > 2.3 &&
                totalFat < 24.0) {
              NotificationServices.scheduleCalorieExceedingBMRNotification();
              NotificationServices.scheduleSodiumNotification();
            } else if (totalSugar < 24.0 &&
                totalSodium < 2.3 &&
                totalFat > 16.0) {
              NotificationServices.scheduleCalorieExceedingBMRNotification();
              NotificationServices.scheduleFatNotification();
            }
          } else if (totalCalorie < userBMR) {
            if (totalSugar > 24.0 && totalSodium > 2.3 && totalFat < 16.0) {
              NotificationServices.scheduleSugerNotification();
              NotificationServices.scheduleSodiumNotification();
            } else if (totalSugar > 24.0 &&
                totalSodium < 2.3 &&
                totalFat > 16.0) {
              NotificationServices.scheduleSugerNotification();
              NotificationServices.scheduleFatNotification();
            } else if (totalSugar < 24.0 &&
                totalSodium > 2.3 &&
                totalFat > 16.0) {
              NotificationServices.scheduleSodiumNotification();
              NotificationServices.scheduleFatNotification();
            } else if (totalSugar > 24.0 &&
                totalSodium < 2.3 &&
                totalFat < 16.0) {
              NotificationServices.scheduleSugerNotification();
            } else if (totalSugar < 24.0 &&
                totalSodium > 2.3 &&
                totalFat < 16.0) {
              NotificationServices.scheduleSodiumNotification();
            } else if (totalSugar < 24.0 &&
                totalSodium < 2.3 &&
                totalFat > 16.0) {
              NotificationServices.scheduleFatNotification();
            }
          }
        }

        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            child: calcaloriePage(
              userId: userId,
            ),
          ),
        );
      }
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  static Future<void> deleteData(
    BuildContext context,
    String Id,
    String label,
  ) async {
    final success = await APIEndpoint.deleteDate(Id, label);
  }

  static Future<void> addWaterUser(
    BuildContext context,
    String userId,
    double amount,
  ) async {
    try {
      String waterId = await userPlugin.generateUserWaterId(userId);

      waterModel waterData = waterModel(waterId: waterId, amount: amount);

      DateTime timestamp = DateTime.now();
      String dateOnly = DateFormat('yyyy-MM-dd').format(timestamp);

      final success =
          await APIEndpoint.addUserWater(userId, waterData, dateOnly);

      if (success) {
        Navigator.pop(
          context,
        );
      }
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  static Future<void> addNews(
    BuildContext context,
    Uint8List? imageFile,
    String news_name,
    String news_link,
    String des,
  ) async {
    String newsId = await userPlugin.generateNewId();
    String imageUrl = await APIEndpoint.uploadImageNews(imageFile!);

    NewsDataModel newsData = NewsDataModel(
      newsId: newsId,
      image_file: imageUrl,
      news_name: news_name,
      news_link: news_link,
      des: des,
    );

    final success = await APIEndpoint.addNewsData(newsData);

    if (success) {
      Navigator.pop(
        context,
      );
    }
  }

  static Future<void> addInfo(
      BuildContext context,
      String userId,
      String email,
      String password,
      File? image_File,
      String username,
      String gender,
      int age,
      double weight,
      double height,
      int Exe_B) async {
    String image = await APIEndpoint.uploadImageToFirebase(image_File);

    UserModel user = UserModel(
      userId: userId,
      email: '',
      password: '',
      username: username,
    );

    HealthDataModel healthData = HealthDataModel(
      userId: userId,
      image_flie: image,
      gender: gender,
      age: age,
      weight: weight,
      height: height,
      exerciseLevel: Exe_B,
    );

    final success = await APIEndpoint.addInfo(user, healthData);

    final bool successLoc = await APIEndpoint.signIn(context, email, password);

    if (success && successLoc) {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: homePage(
            userId: userId,
          ),
        ),
      );
    }
  }

  static Future<void> updateInfo(
      BuildContext context,
      String userId,
      File? image_File,
      String username,
      String gender,
      int age,
      double weight,
      double height,
      int Exe_B) async {
    String image = await APIEndpoint.uploadImageToFirebase(image_File);

    HealthDataModel healthData = HealthDataModel(
      userId: userId,
      image_flie: image,
      gender: gender,
      age: age,
      weight: weight,
      height: height,
      exerciseLevel: Exe_B,
    );

    final success = await APIEndpoint.updateInfo(userId, username, healthData);

    if (success) {
      Navigator.pop(
        context,
      );
    }
  }

  static Future<void> addNoti(
    BuildContext context,
    String userId,
    String labelNotiText,
    String titleNoti,
    String title,
    String note,
    DateTime selectedDate,
    TimeOfDay selectedTime,
  ) async {
    String id = await userPlugin.generateNotiId(userId);

    NotiModel notiModel = NotiModel(
        notiId: id,
        title: title,
        note: note,
        selectedDate: selectedDate,
        selectedTime: selectedTime,
        notiStatus: 'active',
        notiStatusLabel: titleNoti);

    final success = await APIEndpoint.addNoti(userId, notiModel);

    if (success) {
      Navigator.pop(
        context,
        PageTransition(
          type: PageTransitionType.leftToRight,
          child: showNotiScreen(
            userId: userId,
            labelNotiText: labelNotiText,
            titleNoti: titleNoti,
          ),
        ),
      );
    }
  }

  static Future<void> logOut(BuildContext context) async {
    final success = await APIEndpoint.signOut(context);

    if (success != false) {
      Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: MyLandingScreen(),
        ),
      );
    }
  }

  static Future<int> getUserAge(String userId) async {
    return APIEndpoint.getUserAge(userId);
  }

  static Future<double> fetchTotalNutrient(
      String userId, String nutrient) async {
    return APIEndpoint.fetchTotalNutrientForUserToday(userId, nutrient);
  }

  static Future<List<double>> fetchTotalNutrientForWeek(String userId,
      String nutrient, int year, int month, int currentDay) async {
    return APIEndpoint.fetchTotalNutrientForWeek(
        userId, nutrient, year, month, currentDay);
  }

  static Future<void> updateUserFoodStatus(
    BuildContext context,
    String userId,
    String foodId,
  ) async {
    final success = await APIEndpoint.updateUserFoodAndWaterStatus(
        userId, foodId, 'unpick');
  }

  static Future<void> updateUserWaterStatus(
    BuildContext context,
    String userId,
    String waterId,
  ) async {
    final success = await APIEndpoint.updateUserFoodAndWaterStatus(
        userId, waterId, 'unpick');
  }

  static Future<void> updateNotificationStatus(
    BuildContext context,
    String userId,
    String notiId,
  ) async {
    final success = await APIEndpoint.updateNotificationStatus(
        userId, notiId, 'unscheduled');
  }
}
