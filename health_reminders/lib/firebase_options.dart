// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBIPakfi0CYDiWsrR2V12Z6cqtgaXIUN68',
    appId: '1:591465468182:web:7e1c762692906ce258c037',
    messagingSenderId: '591465468182',
    projectId: 'health-reminders-b674f',
    authDomain: 'health-reminders-b674f.firebaseapp.com',
    storageBucket: 'health-reminders-b674f.appspot.com',
    measurementId: 'G-D44YWVM9H0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBqdjv7bnns3OVWxq7n5ibHWbRb26jJ7n8',
    appId: '1:591465468182:android:53aa7926b8f3102958c037',
    messagingSenderId: '591465468182',
    projectId: 'health-reminders-b674f',
    storageBucket: 'health-reminders-b674f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDPH8edmhQr_nRNexgXyFFs8BYDt0HTYJU',
    appId: '1:591465468182:ios:b8d8e3d7b15097c958c037',
    messagingSenderId: '591465468182',
    projectId: 'health-reminders-b674f',
    storageBucket: 'health-reminders-b674f.appspot.com',
    iosBundleId: 'com.example.healthReminders',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDPH8edmhQr_nRNexgXyFFs8BYDt0HTYJU',
    appId: '1:591465468182:ios:b8d8e3d7b15097c958c037',
    messagingSenderId: '591465468182',
    projectId: 'health-reminders-b674f',
    storageBucket: 'health-reminders-b674f.appspot.com',
    iosBundleId: 'com.example.healthReminders',
  );
}