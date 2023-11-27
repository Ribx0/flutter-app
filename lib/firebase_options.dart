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
    apiKey: 'AIzaSyBdru8KMzcH8XpXI27pp1U64_noiMw4ogc',
    appId: '1:917345198886:web:72d3d26aa7f5ba376917e7',
    messagingSenderId: '917345198886',
    projectId: 'laabisaad-e18f3',
    authDomain: 'laabisaad-e18f3.firebaseapp.com',
    storageBucket: 'laabisaad-e18f3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCbn9AW8pu9XSmT6V3Jmf7s23fCGkPyUv0',
    appId: '1:917345198886:android:8766b2e1138d5d606917e7',
    messagingSenderId: '917345198886',
    projectId: 'laabisaad-e18f3',
    storageBucket: 'laabisaad-e18f3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAFtv8xkj06aKrSZEn7oZukScQPKucUiVI',
    appId: '1:917345198886:ios:9dcc8c637f14498c6917e7',
    messagingSenderId: '917345198886',
    projectId: 'laabisaad-e18f3',
    storageBucket: 'laabisaad-e18f3.appspot.com',
    iosBundleId: 'com.example.laabisaad',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAFtv8xkj06aKrSZEn7oZukScQPKucUiVI',
    appId: '1:917345198886:ios:0fb5e0ecf0e8d3db6917e7',
    messagingSenderId: '917345198886',
    projectId: 'laabisaad-e18f3',
    storageBucket: 'laabisaad-e18f3.appspot.com',
    iosBundleId: 'com.example.laabisaad.RunnerTests',
  );
}