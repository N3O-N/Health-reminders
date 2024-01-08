import 'package:flutter/material.dart';
import 'package:health_reminders/styles/color.dart';

final ButtonStyle buttonone = ElevatedButton.styleFrom(
  minimumSize: Size(281, 55),
  primary: yellow,
  //elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  shadowColor: brown,
  elevation: 1,
);

final ButtonStyle buttontwo = ElevatedButton.styleFrom(
  minimumSize: Size(281, 55),
  primary: white,
  //elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    side: BorderSide(color:brown),
  ),
  shadowColor: brown,
  elevation: 1,
);

final ButtonStyle buttonlgin = ElevatedButton.styleFrom(
  minimumSize: Size(133, 40),
  primary: yellow,
  //elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  shadowColor: brown,
  elevation: 1,
);

final ButtonStyle buttonwomen = ElevatedButton.styleFrom(
  minimumSize: Size(281, 55),
  primary: pink,
  //elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  shadowColor: brown,
  elevation: 2,
);

final ButtonStyle buttonman = ElevatedButton.styleFrom(
  minimumSize: Size(281, 55),
  primary: blue,
  //elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  shadowColor: brown,
  elevation: 2,
);

final ButtonStyle buttonbmi = ElevatedButton.styleFrom(
  minimumSize: Size(133, 40),
  primary: green,
  //elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  shadowColor: brown,
  elevation: 1,
);

final ButtonStyle buttonmanu = ElevatedButton.styleFrom(
  minimumSize: Size(133, 40),
  primary: manu,
  //elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  shadowColor: brown,
  elevation: 1,
);

final ButtonStyle buttonnoti = ElevatedButton.styleFrom(
  minimumSize: Size(281, 61),
  primary: noti,
  //elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  shadowColor: brown,
  elevation: 1,
);