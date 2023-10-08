import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../constants/colors.dart';
import '../../../features/auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  static const String routeName = '/landing-screen';
  const LandingScreen({super.key});

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                'Chatify',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 55,
                ),
              ),
              const Text(
                'Chirp, don\'t be shy.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: tabColor,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: size.height / 9),
              Lottie.asset(
                'assets/animations/landing_logo.json',
                fit: BoxFit.cover,
                reverse: true,
              ),
              SizedBox(height: size.height / 8),
              Padding(
                padding: const EdgeInsets.all(15),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    text: 'Read our ',
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      TextSpan(
                          text: '. Tap "Agree and Continue" to \naccept the '),
                      TextSpan(
                          text: "Terms of Service",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                child: CustomButton(
                  text: 'AGREE AND CONTINUE',
                  onPress: () => navigateToLoginScreen(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
