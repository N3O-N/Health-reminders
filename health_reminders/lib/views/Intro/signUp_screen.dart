import 'package:flutter/material.dart';
import 'package:health_reminders/controller/operator.dart';
import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/custom_app_bar.dart';
import 'package:health_reminders/styles/text.dart';
import 'package:health_reminders/views/Intro/signIn_screen.dart';
import 'package:page_transition/page_transition.dart';

class signUpScreen extends StatefulWidget {
  @override
  _signUpScreenState createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  bool obscureTextpass = true;
  bool obscureTextpasscon = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          onBackButtonPressed: () {
            Navigator.pop(context);
          },
          title: ''),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 120,
                ),
                Text(
                  'สมัครสมาชิก',
                  style: TextStyle(
                      color: Color.fromRGBO(107, 89, 24, 1),
                      fontFamily: 'Garuda',
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    //ช่องกรอกอีเมล์
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 12.0),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              color: brown, // สีของ labelText
                              fontSize: 16,
                              fontFamily: 'Garuda' // ขนาด font ของ labelText
                              ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),

                    //ช่องกรอก รหัส
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 12.0),
                      child: TextField(
                        controller: passwordController,
                        obscureText: obscureTextpass,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              color: brown, // สีของ labelText
                              fontSize: 16,
                              fontFamily: 'Garuda' // ขนาด font ของ labelText
                              ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                // สลับค่าให้กับ obscureText เมื่อปุ่มถูกกด
                                obscureTextpass = !obscureTextpass;
                              });
                            },
                            icon: Icon(
                              obscureTextpass
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: obscureTextpass ? Colors.grey : yellow,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),

                    //ช่องคอน รหัส
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 12.0),
                      child: TextField(
                        controller: passwordConfirmController,
                        obscureText: obscureTextpasscon,
                        decoration: InputDecoration(
                          labelText: 'confirm password',
                          labelStyle: TextStyle(
                              color: brown, // สีของ labelText
                              fontSize: 16,
                              fontFamily: 'Garuda' // ขนาด font ของ labelText
                              ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                // สลับค่าให้กับ obscureText เมื่อปุ่มถูกกด
                                obscureTextpasscon = !obscureTextpasscon;
                              });
                            },
                            icon: Icon(
                              obscureTextpasscon
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: obscureTextpasscon ? Colors.grey : yellow,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                //ปุ่มยืนยัน
                ElevatedButton(
                  style: buttonlgin,
                  onPressed: () {
                    // Handle the first button press
                    print('Button SignUp Pressed');
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        passwordConfirmController.text.isEmpty) {
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
                        passwordController.text.isNotEmpty &&
                        passwordConfirmController.text.isNotEmpty) {
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
                      } else if (passwordController.text.length < 6 ||
                          passwordConfirmController.text.length < 6) {
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
                        UserOperator.newSignUp(
                            context,
                            emailController.text,
                            passwordController.text,
                            passwordConfirmController.text);
                      }
                    }
                  },
                  child: Text('สมัคร', style: TextStyles.Tlogin),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  child: Text(
                    'หรือ',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 43, 48,
                          53), // You can change the color as needed
                      fontSize: 14,
                      fontFamily: 'Garuda',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    // Handle the "Forgot Password" action
                    print('go to loginpage');
                    Navigator.push(
                      context,
                      PageTransition(
                          child: signInScreen(),
                          type: PageTransitionType.rightToLeft),
                    );
                  },
                  child: Text(
                    'เข้าสู่ระบบ',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 43, 48,
                          53), // You can change the color as needed
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
