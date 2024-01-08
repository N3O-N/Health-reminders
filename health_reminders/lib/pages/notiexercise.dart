import 'package:flutter/material.dart';
import 'package:health_reminders/pages/notiexercire2.dart';
import 'package:health_reminders/styles/button.dart';
import 'package:health_reminders/styles/color.dart';
import 'package:health_reminders/styles/text.dart';

class notiexcerisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: Text( 'เวลาออกกำลังกาย', 
            style: TextStyle(
            color: Colors.brown, // Assuming 'brown' is a defined color variable
            fontFamily: 'Garuda',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            
          ),
        ),

          actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => notiexercise2Page()),
                      );
            },
          ),
        ],
      ),


      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[

  

              ],
            ),
          ),
        ),
      ),
    );
  }
}
