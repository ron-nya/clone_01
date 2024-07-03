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
    apiKey: 'AIzaSyBiTkpXicywbCy6GwvYHFOHFXJDyI2-PBQ',
    appId: '1:877746909827:web:8ddcc74055c93ba3d261b6',
    messagingSenderId: '877746909827',
    projectId: 'my-nomad-test01',
    authDomain: 'my-nomad-test01.firebaseapp.com',
    storageBucket: 'my-nomad-test01.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyALqzlLzLEXBPCfpMSCGRrN22OhzHb-_Wc',
    appId: '1:877746909827:android:cff2259beca2b1b4d261b6',
    messagingSenderId: '877746909827',
    projectId: 'my-nomad-test01',
    storageBucket: 'my-nomad-test01.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCWQOlVIHAFpWRtSzvGyRiopOf2I2HP4VA',
    appId: '1:877746909827:ios:afe7c48b2b804bdad261b6',
    messagingSenderId: '877746909827',
    projectId: 'my-nomad-test01',
    storageBucket: 'my-nomad-test01.appspot.com',
    iosBundleId: 'com.example.authentication.RunnerTests',
  );

}