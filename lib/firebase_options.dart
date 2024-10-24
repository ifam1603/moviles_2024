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
        return windows;
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
    apiKey: 'AIzaSyDm7mQQTfHC-ldZrGvRYUi7WQAzP2c_eWQ',
    appId: '1:360052265500:web:1dd8e0b481c0444dc605d9',
    messagingSenderId: '360052265500',
    projectId: 'moviles-1603',
    authDomain: 'moviles-1603.firebaseapp.com',
    storageBucket: 'moviles-1603.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7chE_lt2DOlbty4f_eDyTm5qv48cW_tk',
    appId: '1:360052265500:android:8483df03bed3b8e2c605d9',
    messagingSenderId: '360052265500',
    projectId: 'moviles-1603',
    storageBucket: 'moviles-1603.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD6rdM5GgyL97ylm86_WzxX6GuVuRc0DHo',
    appId: '1:360052265500:ios:c5dd8a600d431e61c605d9',
    messagingSenderId: '360052265500',
    projectId: 'moviles-1603',
    storageBucket: 'moviles-1603.appspot.com',
    iosBundleId: 'com.example.moviles2024',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD6rdM5GgyL97ylm86_WzxX6GuVuRc0DHo',
    appId: '1:360052265500:ios:c5dd8a600d431e61c605d9',
    messagingSenderId: '360052265500',
    projectId: 'moviles-1603',
    storageBucket: 'moviles-1603.appspot.com',
    iosBundleId: 'com.example.moviles2024',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDm7mQQTfHC-ldZrGvRYUi7WQAzP2c_eWQ',
    appId: '1:360052265500:web:8e95d9d6deeaa7bec605d9',
    messagingSenderId: '360052265500',
    projectId: 'moviles-1603',
    authDomain: 'moviles-1603.firebaseapp.com',
    storageBucket: 'moviles-1603.appspot.com',
  );
}
