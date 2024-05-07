import 'package:flutter/material.dart';
import 'package:health_reminders/controller/operator.dart';
import 'package:health_reminders/controller/plugin.dart';
import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/custom_app_bar.dart';
import 'package:health_reminders/styles/text.dart';
import 'package:health_reminders/views/Home/home.dart';

import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class waterPage extends StatelessWidget {
  final String userId;
  waterPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    double boxSizeWidth = 345;

    DateTime currentDate = DateTime.now();

    String formatteDate = DateFormat('dd/MM/yyyy').format(currentDate);

    final TextEditingController qtyController = TextEditingController();

    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
          onBackButtonPressed: () {
            Navigator.pushReplacement(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: homePage(
                  userId: userId,
                ),
              ),
            );
          },
          title: "การดื่มน้ำ"),
      body: SingleChildScrollView(
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
                  showDataHealthPlugin(
                    docId: userId,
                    otherClass: (context, healthData) =>
                        wathercalWidget(healthDataSet: healthData),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  showDataPlugin(
                    docId: userId,
                    otherClass: (context, usersData, healthData) =>
                        BuildAmountWaterListView(
                            usersDataSet: usersData, healthDataSet: healthData),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '*กรอกเฉพาะปริมาณของน้ำเปล่าเท่านั้น*',
                            style: TextStyles.common7,
                            textAlign: TextAlign.end,
                          ),
                          SizedBox(width: 40.0),
                        ],
                      ),
                    ],
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'รายการการดื่มน้ำ',
                              style: TextStyles.common3,
                              textAlign: TextAlign.end,
                            ),
                            IconButton(
                              icon: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'เพิ่มน้ำดื่ม',
                                    style: TextStyles.Tlogin,
                                  ),
                                ],
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) => Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                    child: Container(
                                      height: 230,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "เพิ่มปริมาณการดื่มน้ำ",
                                            style: TextStyles.Tlogin,
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: TextField(
                                              controller: qtyController,
                                              decoration: InputDecoration(
                                                labelText: 'ปริมาณน้ำดื่ม',
                                                labelStyle: TextStyle(
                                                    color:
                                                        brown, // สีของ labelText
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'Garuda' // ขนาด font ของ labelText
                                                    ),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 12.0,
                                                        horizontal: 15.0),
                                                border: OutlineInputBorder(),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ElevatedButton(
                                            style: buttonlgin,
                                            onPressed: () {
                                              UserOperator.addWaterUser(
                                                context,
                                                userId,
                                                double.parse(
                                                  qtyController.text.trim(),
                                                ),
                                              );
                                              Navigator.pushReplacement(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: waterPage(
                                                    userId: userId,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text('เพิ่ม',
                                                style: TextStyles.Tlogin),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              tooltip: 'เพิ่มน้ำดื่ม',
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
                        docId: userId,
                        otherClass: (context, usersData, healthData) =>
                            BuildUserWaterListView(
                                usersDataSet: usersData,
                                healthDataSet: healthData),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
