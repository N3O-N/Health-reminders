import 'package:flutter/material.dart';
import 'package:health_reminders/controller/plugin.dart';
import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/custom_app_bar.dart';
import 'package:health_reminders/styles/text.dart';
import 'package:health_reminders/views/Intro/signUp_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../controller/operator.dart';

class signInScreen extends StatefulWidget {
  @override
  _signInScreenState createState() => _signInScreenState();
}

class _signInScreenState extends State<signInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscureText = true; //เก็บสถานะการแสดงรหัสผ่าน

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
        title: '',
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 150,
                ),
                Text(
                  'เข้าสู่ระบบ',
                  style: TextStyle(
                    color: Color.fromRGBO(107, 89, 24, 1),
                    fontFamily: 'Garuda',
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 12.0,
                      ),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: brown,
                            fontSize: 16,
                            fontFamily: 'Garuda',
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 15.0,
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 12.0,
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText:
                            obscureText, // ใช้ค่าของ obscureText ที่ประกาศไว้
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: brown,
                            fontSize: 16,
                            fontFamily: 'Garuda',
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 15.0,
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                // สลับค่าให้กับ obscureText เมื่อปุ่มถูกกด
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: obscureText ? Colors.grey : yellow,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 285,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Handle the "Forgot Password" action
                            print('Forgot Password tapped');
                          },
                          child: Text(
                            'ลืมรหัสผ่าน?',
                            style: TextStyle(
                              color: const Color.fromARGB(
                                255,
                                43,
                                48,
                                53,
                              ),
                              decoration: TextDecoration.underline,
                              fontFamily: 'Garuda',
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: buttonlgin,
                  onPressed: () async {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('แจ้งเตือน'),
                            content: Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
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
                    } else if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(emailController.text)) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('แจ้งเตือน'),
                              content: Text('อีเมลไม่ถูกต้อง'),
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
                      } else if (passwordController.text.length < 6) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('แจ้งเตือน'),
                              content:
                                  Text('รหัสผ่านต้องมีความยาวอย่างน้อย 6 ตัว'),
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
                        // Proceed with login
                        bool success = await UserOperator.login(context,
                            emailController.text, passwordController.text);
                        if (success) {
                          await NotificationServices.InitializaNotification();
                          // กำหนดค่า isLoggedIn เป็น true เมื่อเข้าสู่ระบบสำเร็จ
                          SessionManagerPlugin.isLoggedIn = true;
                          print('เข้าสู่ระบบ');
                        } else {
                          print('ไม่สามารถเข้าสู่ระบบได้');
                        }
                      }
                    }
                  },
                  child: Text('เข้าสู่ระบบ', style: TextStyles.Tlogin),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'หรือ',
                  style: TextStyle(
                    color: const Color.fromARGB(
                      255,
                      43,
                      48,
                      53,
                    ),
                    fontSize: 14,
                    fontFamily: 'Garuda',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    // Handle the "Forgot Password" action
                    print('go to registerpage');
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: signUpScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'สมัครสมาชิก',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 43, 48, 53),
                      fontSize: 14,
                      fontFamily: 'Garuda',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
