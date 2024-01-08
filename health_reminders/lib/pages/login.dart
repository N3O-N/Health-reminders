import 'package:flutter/material.dart';
import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/text.dart';

class loginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
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
                      fontSize: 24),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
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
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 12.0),
                      child: TextField(
                        controller: passwordController,
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
                        ),
                      ),
                    ),
                  ],
                ),

                //SizedBox(height: 5,),
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
                              color: const Color.fromARGB(255, 43, 48,53), // You can change the color as needed
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
                  onPressed: () {
                    // Handle the first button press
                    print('Button 1 Pressed');
                  },
                  child: Text('เข้าสู่ระบบ', style: TextStyles.Tlogin),
                ),

                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                         
                          child: Text('หรือ', style: TextStyle(
                              color: const Color.fromARGB(255, 43, 48, 53), // You can change the color as needed
                              fontSize: 14,
                              fontFamily: 'Garuda',
                            ),
                          ),
                   ),
        
                SizedBox(height: 10,),
                GestureDetector(
                          onTap: () {
                            // Handle the "Forgot Password" action
                            print('go to registerpage');
                          },
                         
                          child: Text('สมัครสมาชิก', style: TextStyle(
                              color: const Color.fromARGB(255, 43, 48, 53), // You can change the color as needed
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
