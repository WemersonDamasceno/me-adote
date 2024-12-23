// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBBgjlpn3OkNjTuG9BBpWi0JMufk1aUpkE',
    appId: '1:402369554375:android:c9a2685cfe9d1995a65be2',
    messagingSenderId: '402369554375',
    projectId: 'me-adote-5b6c8',
    databaseURL: 'https://me-adote-5b6c8-default-rtdb.firebaseio.com',
    storageBucket: 'me-adote-5b6c8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAERZl8TICpgAeIcC1sG2Ws0HI6t6aT0CI',
    appId: '1:402369554375:ios:4af5c981f84454ada65be2',
    messagingSenderId: '402369554375',
    projectId: 'me-adote-5b6c8',
    databaseURL: 'https://me-adote-5b6c8-default-rtdb.firebaseio.com',
    storageBucket: 'me-adote-5b6c8.firebasestorage.app',
    iosBundleId: 'com.example.meAdota',
  );
}
