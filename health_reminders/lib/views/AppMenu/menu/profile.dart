import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:health_reminders/controller/operator.dart';
import 'package:health_reminders/styles/color.dart'; // Assuming you have a file named user_operator.dart for data fetching

class profilePage extends StatelessWidget {
  final String userId;
  const profilePage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading:
                  false, // This property is redundant and not needed here
              centerTitle: true,
              backgroundColor: white,
              elevation: 0.0,
              title: Text(
                'สรุปผล',
                style: TextStyle(
                  color: Colors
                      .brown, // Assuming 'brown' is a defined color variable
                  fontFamily: 'Garuda',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'แคลอรี่ที่ได้รับในแต่ละวัน',
                      style: TextStyle(
                        color: Colors
                            .brown, // Assuming 'brown' is a defined color variable
                        fontFamily: 'Garuda',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: SizedBox(
                      height: 200,
                      child: MyBarGraph(
                        userId: userId,
                        gettoknows: 'calorie',
                      ),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'น้ำตาลที่ได้รับในแต่ละวัน',
                      style: TextStyle(
                        color: Colors
                            .brown, // Assuming 'brown' is a defined color variable
                        fontFamily: 'Garuda',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: SizedBox(
                      height: 200,
                      child: MyBarGraph(
                        userId: userId,
                        gettoknows: 'suger',
                      ),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ไขมันที่ได้รับในแต่ละวัน',
                      style: TextStyle(
                        color: Colors
                            .brown, // Assuming 'brown' is a defined color variable
                        fontFamily: 'Garuda',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: SizedBox(
                      height: 200,
                      child: MyBarGraph(
                        userId: userId,
                        gettoknows: 'fat',
                      ),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'โซเดียมที่ได้รับในแต่ละวัน',
                      style: TextStyle(
                        color: Colors
                            .brown, // Assuming 'brown' is a defined color variable
                        fontFamily: 'Garuda',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: SizedBox(
                      height: 200,
                      child: MyBarGraph(
                        userId: userId,
                        gettoknows: 'sodium',
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyBarGraph extends StatefulWidget {
  final String userId;
  final String gettoknows;

  MyBarGraph({required this.userId, required this.gettoknows});

  @override
  _MyBarGraphState createState() => _MyBarGraphState();
}

class _MyBarGraphState extends State<MyBarGraph> {
  late List<double> daysummary = [];

  @override
  void initState() {
    super.initState();
    fetchNutrientData();
  }

  Future<void> fetchNutrientData() async {
    List<double> nutrientData = await UserOperator.fetchTotalNutrientForWeek(
        widget.userId,
        widget.gettoknows,
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day);

    setState(() {
      daysummary = nutrientData;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (daysummary.isEmpty) {
      return Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      double max = daysummary
          .reduce((value, element) => value > element ? value : element);

      double maxRoundedUp;

      if (max < 100) {
        maxRoundedUp = (max.ceilToDouble() / 100).ceilToDouble() * 100;
      } else {
        maxRoundedUp = (max.ceilToDouble() / 1000).ceilToDouble() * 1000;
      }
      return BarChart(
        BarChartData(
          maxY: maxRoundedUp,
          minY: 0,
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: getBottomTitles,
              ),
            ),
          ),
          barGroups: daysummary
              .asMap()
              .entries
              .map(
                (entry) => BarChartGroupData(
                  x: entry.key + 1,
                  barRods: [
                    BarChartRodData(
                      toY: entry.value,
                      color: brown,
                      width: 20,
                      borderRadius: BorderRadius.circular(4),
                      backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: maxRoundedUp,
                          color: Colors.grey[200]),
                    )
                  ],
                ),
              )
              .toList(),
        ),
      );
    }
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.brown, // Assuming 'brown' is a defined color variable
    fontFamily: 'Garuda',
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  late Widget text;
  switch (value.toInt()) {
    case 1:
      text = const Text(
        'จ.',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        'อ.',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        'พ.',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        'พฤ.',
        style: style,
      );
      break;
    case 5:
      text = const Text(
        'ศ.',
        style: style,
      );
      break;
    case 6:
      text = const Text(
        'ส.',
        style: style,
      );
      break;
    case 7:
      text = const Text(
        'อา.',
        style: style,
      );
      break;
  }

  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
