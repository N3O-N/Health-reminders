import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:health_reminders/controller/plugin.dart';
import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/text.dart';
import 'package:health_reminders/views/AppMenu/exercise/exercise.dart';
import 'package:health_reminders/views/AppMenu/menu/bmr_bmr_page.dart';
import 'package:health_reminders/views/AppMenu/menu/calcalorie.dart';
import 'package:health_reminders/views/AppMenu/menu/food.dart';
import 'package:health_reminders/views/AppMenu/menu/news.dart';
import 'package:health_reminders/views/AppMenu/menu/profile.dart';
import 'package:health_reminders/views/AppMenu/menu/setting.dart';
import 'package:health_reminders/views/AppMenu/menu/water.dart';
import 'package:health_reminders/views/AppMenu/notification/notificationScreen.dart';
import 'package:page_transition/page_transition.dart';

class homePage extends StatefulWidget {
  final String userId;
  const homePage({required this.userId});

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      HomePageContent(
        userId: widget.userId,
      ),
      profilePage(userId: widget.userId),
      settingPage(userId: widget.userId),
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
            icon: Icon(Icons.summarize),
            label: 'สรุปผล',
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
                    'HEALTH REMINDER',
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
                          Flexible(
                            child: Text(
                              'เมนู',
                              textAlign: TextAlign.end,
                            ),
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
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: calcaloriePage(
                                    userId: userId,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'asset/image/calories.png',
                                  width: 50.0,
                                  height: 50.0,
                                ),
                                Flexible(
                                    child: Text('คำนวณแคลอรี่',
                                        style: TextStyles.common4)),
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
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: foodPage(
                                    userId: userId,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'asset/image/food.png',
                                  width: 50.0,
                                  height: 50.0,
                                ),
                                Flexible(
                                    child: Text('อาหาร',
                                        style: TextStyles.common4)),
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
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: waterPage(userId: userId),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'asset/image/water.png',
                                  width: 50.0,
                                  height: 50.0,
                                ),
                                Flexible(
                                    child:
                                        Text('น้ำ', style: TextStyles.common4)),
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
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: exercisePage(),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'asset/image/xcercise.png',
                                  width: 50.0,
                                  height: 50.0,
                                ),
                                Flexible(
                                    child: Text('ออกกำลังกาย',
                                        style: TextStyles.common4)),
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
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: bmi_bmr_page(
                                    userId: userId,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'asset/image/bmibmr.png',
                                  width: 50.0,
                                  height: 50.0,
                                ),
                                Flexible(
                                    child: Text('BMI/BMR',
                                        style: TextStyles.common4)),
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
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: notificationScreen(
                                    userId: userId,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'asset/image/reminder.png',
                                  width: 50.0,
                                  height: 50.0,
                                ),
                                Flexible(
                                    child: Text('แจ้งเตือน',
                                        style: TextStyles.common4)),
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
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: newsPage(
                                    userId: userId,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'asset/image/news.png',
                                  width: 50.0,
                                  height: 50.0,
                                ),
                                Flexible(
                                  child: Text('ข่าวสารสุขภาพ',
                                      style: TextStyles.common4),
                                ),
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
