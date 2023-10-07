import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatify/common/widgets/error.dart';
import 'package:chatify/common/widgets/loader.dart';
import 'package:chatify/constants/colors.dart';
import 'package:chatify/features/auth/controller/auth_controller.dart';
import 'package:chatify/router.dart';
import 'package:chatify/platform_roots/android/screens/landing_screen.dart';
import 'package:chatify/firebase_options.dart';
import 'package:chatify/platform_roots/android/screens/mobile_screen_layout.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatify',
      theme: ThemeData(
        colorScheme: ThemeData.light().colorScheme.copyWith(
              background: backgroundColor,
              brightness: Brightness.light,
            ),
        appBarTheme: const AppBarTheme(
            // backgroundColor: appBarColor,
            ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userDataAuthProvider).when(
          data: (user) {
            if (user == null) return const LandingScreen();
            return const MobileScreenLayout();
          },
          error: (error, trace) {
            return ErrorScreen(error: error.toString());
          },
          loading: () => const Loader()),
    );
  }
}
