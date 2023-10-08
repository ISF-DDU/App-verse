import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/utils.dart';
import '../../../common/widgets/custom_button.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  Country? _country;

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country country) {
          setState(() {
            _country = country;
          });
        });
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneNumberController.text.trim();
    if (_country != null && phoneNumber.isNotEmpty) {
      ref.read(authControllerProvider).signInWithPhoneNumber(
          context: context, phoneNumber: '+${_country!.phoneCode}$phoneNumber');
      debugPrint(phoneNumber);
    } else {
      showSnackBar(context: context, content: 'Fill out all the fields!');
    }
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Center(
          child: Text(
            'Enter your phone number',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text:
                      "Chatify will send an SMS to verify your\n phone number. ",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  children: [
                    TextSpan(
                        text: "What's my number?",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: pickCountry,
              child: Text(
                _country == null
                    ? 'Pick Country'
                    : _country!.displayNameNoCountryCode,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 20),
                if (_country != null) Text("+${_country!.phoneCode}"),
                const SizedBox(width: 10),
                SizedBox(
                  width: size.width * 0.6,
                  child: TextField(
                    controller: phoneNumberController,
                    decoration: const InputDecoration(
                      hintText: 'Phone Number',
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
            CustomButton(
              text: 'Let\'s Verify',
              onPress: sendPhoneNumber,
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
