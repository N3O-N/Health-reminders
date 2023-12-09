import 'package:flutter/material.dart';

class landingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Landing Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Handle the first button press
                print('Button 1 Pressed');
              },
              child: Text('Button 1'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle the second button press
                print('Button 2 Pressed');
              },
              child: Text('Button 2'),
            ),
          ],
        ),
      ),
    );
  }
}
