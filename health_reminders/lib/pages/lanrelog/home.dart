import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:health_reminders/controller/operator.dart';
import 'package:health_reminders/controller/plugin.dart';
import 'package:health_reminders/pages/exercise/exercise.dart';
import 'package:health_reminders/pages/menu/bmr_bmr_page.dart';
import 'package:health_reminders/pages/menu/calcalorie.dart';
import 'package:health_reminders/pages/menu/food.dart';
import 'package:health_reminders/pages/menu/news.dart';
import 'package:health_reminders/pages/menu/profile.dart';
import 'package:health_reminders/pages/menu/setting.dart';
import 'package:health_reminders/pages/menu/water.dart';
import 'package:health_reminders/pages/notification/notificationScreen.dart';
import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/text.dart';

class homePage extends StatefulWidget {
  final String userId;
  const homePage({required this.userId});

  @override
  _homePageState createState() => _homePageState(userId: userId);
}

class _homePageState extends State<homePage> {
  int _selectedIndex = 0;
  final String userId;

  _homePageState({required this.userId});

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePageContent(
        userId: widget.userId,
      ),
      profilePage(userId: widget.userId),
      settingPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: white,
        selectedItemColor: yellow, // เปลี่ยนสีของข้อความที่เลือก
        unselectedItemColor: brown, // เปลี่ยนสีของข้อความที่ไม่ได้เลือก
        selectedFontSize: 16, // เปลี่ยนขนาดข้อความของข้อความที่เลือก
        unselectedFontSize: 14,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'โปรไฟล์',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'ตั้งค่า',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  final String userId;
  HomePageContent({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 253, 248, 236),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.zero,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Color.fromARGB(255, 244, 233, 206),
                  centerTitle: true,
                  elevation: 0.0,
                  title: Text(
                    'HEALTHREMINDER',
                    style: TextStyle(
                      color: Colors.brown,
                      fontFamily: 'Garuda',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                showDataPlugin(
                  docId: userId,
                  otherClass: (context, usersData, healthData) =>
                      homeProfileWidget(
                          usersDataSet: usersData, healthDataSet: healthData),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 20), blurRadius: 0, color: white),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.menu,
                            color: brown,
                            size: 15.0,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'เมนู',
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: double
                              .infinity, // ตั้งค่าเป็น double.infinity เพื่อให้ช่องว่างทั้งหมดเท่ากัน
                          height: 100.0,
                          child: ElevatedButton(
                            style: buttonmanu,
                            onPressed: () {
                              // Handle the first button press
                              print('Button 1 Pressed');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => calcaloriePage()),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Icon(Icons.menu, color: brown,size: 15.0,),
                                Text('คำนวณแคลอรี่', style: TextStyles.Tlogin),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 100.0,
                          child: ElevatedButton(
                            style: buttonmanu,
                            onPressed: () {
                              // Handle the first button press
                              print('go to foodpage');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => foodPage()),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('อาหาร', style: TextStyles.Tlogin),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 100.0,
                          child: ElevatedButton(
                            style: buttonmanu,
                            onPressed: () {
                              // Handle the first button press
                              print('go to waterpage');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => waterPage()),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('น้ำ', style: TextStyles.Tlogin),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: double
                              .infinity, // ตั้งค่าเป็น double.infinity เพื่อให้ช่องว่างทั้งหมดเท่ากัน
                          height: 100.0,
                          child: ElevatedButton(
                            style: buttonmanu,
                            onPressed: () {
                              // Handle the first button press
                              print('Button go to exercisepage');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => exercisePage()),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('ออกกำลังกาย', style: TextStyles.Tlogin),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 100.0,
                          child: ElevatedButton(
                            style: buttonmanu,
                            onPressed: () {
                              // Handle the first button press
                              print('Button 2 Pressed');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => bmi_bmr_page()),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('BMI/BMR', style: TextStyles.Tlogin),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 100.0,
                          child: ElevatedButton(
                            style: buttonmanu,
                            onPressed: () {
                              // Handle the first button press
                              print('Button 3 Pressed');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => notificationScreen()),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('แจ้งเตือน', style: TextStyles.Tlogin),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          width:
                              20.0, // ตั้งค่าเป็น double.infinity เพื่อให้ช่องว่างทั้งหมดเท่ากัน
                          height: 100.0,
                          child: ElevatedButton(
                            style: buttonmanu,
                            onPressed: () {
                              // Handle the first button press
                              print('Button go to news page');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => newsPage()),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('ข่าวสารสุขภาพ', style: TextStyles.Tlogin),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Container(
                          width:
                              20.0, // ตั้งค่าเป็น double.infinity เพื่อให้ช่องว่างทั้งหมดเท่ากัน
                          height: 100.0,
                          child: SizedBox(),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Container(
                          width:
                              20.0, // ตั้งค่าเป็น double.infinity เพื่อให้ช่องว่างทั้งหมดเท่ากัน
                          height: 100.0,
                          child: SizedBox(),
                        ),
                      ),
                      SizedBox(width: 10.0),
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
