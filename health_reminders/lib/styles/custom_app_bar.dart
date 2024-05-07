import 'package:flutter/material.dart';
import 'package:health_reminders/styles/color.dart';

class CustomAppBarIconActions extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback onBackButtonPressed;
  final VoidCallback onAddButtonPressed;
  final String title;

  CustomAppBarIconActions(
      {required this.onBackButtonPressed,
      required this.onAddButtonPressed,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.brown, // Assuming 'brown' is a defined color variable
          fontFamily: 'Garuda',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.brown),
        onPressed: onBackButtonPressed,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.add_circle_outline,
            color: Colors.brown,
          ),
          onPressed: onAddButtonPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class CustomAppBarTextActions extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback onBackButtonPressed;
  final VoidCallback onActionButtonPressed;
  final String title, textAction;

  CustomAppBarTextActions(
      {required this.onBackButtonPressed,
      required this.onActionButtonPressed,
      required this.title,
      required this.textAction});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.brown, // Assuming 'brown' is a defined color variable
          fontFamily: 'Garuda',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.brown),
        onPressed: onBackButtonPressed,
      ),
      actions: [
        GestureDetector(
          onTap: onActionButtonPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              textAction,
              style: TextStyle(
                color: const Color.fromARGB(255, 43, 48, 53),
                decoration: TextDecoration.underline,
                fontFamily: 'Garuda',
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackButtonPressed;
  final String title;

  CustomAppBar({required this.onBackButtonPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.brown, // Assuming 'brown' is a defined color variable
          fontFamily: 'Garuda',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.brown),
        onPressed: onBackButtonPressed,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
