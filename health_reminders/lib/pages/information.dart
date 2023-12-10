import 'package:flutter/material.dart';
import 'package:health_reminders/pages/gender.dart';
import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/text.dart';

class informationPage extends StatefulWidget {
  @override
  _informationPageState createState() => _informationPageState();
}

class _informationPageState extends State<informationPage> {
  String? valueselect;
  List listitem = [ "ไม่มีการออกกำลังกาย", 
                    "ออกกำลังกายเล็กน้อยอาทิตย์ละ 1-3 วัน", 
                    "ออกกำลังกายปานกลางอาทิตย์ละ 3-5 วัน", 
                    "ออกกำลังกายอย่างหนักอาทิตย์ละ 6-7 วัน",
                    "ออกกำลังกายอย่างหนักทุกวัน" ];

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'ข้อมูล',
          style: TextStyle(
            color: brown,
            fontFamily: 'Garuda',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 120,
                ),
                Text(
                  'ใส่รูปอย่างไร',
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
                          labelText: 'ชื่อ',
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 12.0),
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'อายุ',
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 12.0),
                      child: TextField(
                        controller: passwordController,
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
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1,
                ),
                Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 12.0),

                      child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // สีขอบ
                          width: 1.0, // ขนาดความหนาขอบ
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      
                      child: DropdownButton(
                        hint: Text("ระดับการออกกำลังกาย",
                        style: TextStyle(
                        color: brown, // สีของ hint text
                        fontSize: 16, // ขนาด font ของ hint text
                        fontFamily: 'Garuda',
                        ),
                        ),
                        icon: Icon(Icons.arrow_drop_down , color: brown,),
                        iconSize: 36,
                        style: TextStyle(
                                          color: brown,
                                          fontSize: 16,
                                          fontFamily: 'Garuda',
                                        ),
                        value: valueselect,
                        onChanged: (newValue) {
                          setState(() {
                            valueselect = newValue as String?;
                          });
                        },
                        items: listitem.map((item) {
                          return DropdownMenuItem(
                            value: item as String?,
                            child: Text(item! ,style: TextStyle(
                                                color: brown, // สีของเนื้อหาใน DropdownMenuItem
                                                fontSize: 16, // ขนาด font ของเนื้อหาใน DropdownMenuItem
                                                fontFamily: 'Garuda',
                                              ),),
                          );
                        }).toList(),
                      ),
                    ),

                //SizedBox(
                 // height: 10,
                ),
                ElevatedButton(
                  style: buttonlgin,
                  onPressed: () {
                    // Handle the first button press
                    print('Button 1 Pressed');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => genderPage()),
                    );
                  },
                  child: Text('ยืนยัน', style: TextStyles.Tlogin),
                ),
               
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    // Handle the "Forgot Password" action
                    print('go to loginpage');
                  },
                  child: Text(
                    'เข้าสู่ระบบ',
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
