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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAq4gWdQoTNrsvBHqoeNeWq5vuB2izw4E4',
    appId: '1:238883058201:web:aff55e0122861bed60f088',
    messagingSenderId: '238883058201',
    projectId: 'my-fire-flut',
    authDomain: 'my-fire-flut.firebaseapp.com',
    storageBucket: 'my-fire-flut.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDwatVFs61wcn1BrwzG1Z-WBPxuVEZgV_M',
    appId: '1:238883058201:android:74000d0f7688c53e60f088',
    messagingSenderId: '238883058201',
    projectId: 'my-fire-flut',
    storageBucket: 'my-fire-flut.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDdJb9QFCe8ZEkeV4PMJztPyLu4uoH0BaM',
    appId: '1:238883058201:ios:feec700c0f05047560f088',
    messagingSenderId: '238883058201',
    projectId: 'my-fire-flut',
    storageBucket: 'my-fire-flut.appspot.com',
    iosClientId: '238883058201-9t91nu4lkldpvsvtfle7k18iuus62epp.apps.googleusercontent.com',
    iosBundleId: 'com.example.myFire',
  );
}
