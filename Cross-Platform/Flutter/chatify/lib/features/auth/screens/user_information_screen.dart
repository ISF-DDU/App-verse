import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/utils.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../constants/colors.dart';
import '../../../constants/urls.dart';
import '../controller/auth_controller.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user-information-screen';
  const UserInformationScreen({super.key});

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;

  void pickImage() async {
    image = await pickImageFromGallery(context);
    userProfilePhoto = image;
    setState(() {});
  }

  void storeUserData() async {
    String name = nameController.text.trim();
    if (name.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .saveUserDataToFirebase(context, name, image);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
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
              SizedBox(height: size.height * 0.05),
              Stack(
                children: [
                  image == null
                      ? CircleAvatar(
                          backgroundImage: AssetImage(profileUrl),
                          backgroundColor: Colors.grey,
                          radius: 65,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                            image!,
                          ),
                          radius: 65,
                        ),
                  Positioned(
                    bottom: -5,
                    right: -5,
                    child: TextButton(
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      onPressed: pickImage,
                      child: const CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 15,
                        child: Icon(
                          Icons.add,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: size.width * 0.85,
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  enabled: true,
                  decoration: const InputDecoration(
                    hintText: "Enter your name",
                    focusColor: tabColor,
                  ),
                ),
              ),
              const Spacer(),
              CustomButton(
                text: "Create Profile",
                onPress: storeUserData,
              ),
              SizedBox(height: size.height / 9),
            ],
          ),
        ),
      ),
    );
  }
}
