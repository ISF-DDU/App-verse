import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';

import 'responsive_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    setPathUrlStrategy();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAC-VByUiKYfMH2rKooIBJutu26RKYcoXU",
          authDomain: "budget-app-93518.firebaseapp.com",
          projectId: "budget-app-93518",
          storageBucket: "budget-app-93518.appspot.com",
          messagingSenderId: "87787815661",
          appId: "1:87787815661:web:fc68f0f19adc6747a182e4",
          measurementId: "G-V37M6JTNHD"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: ResponsiveHandler(),
    );
  }
}
