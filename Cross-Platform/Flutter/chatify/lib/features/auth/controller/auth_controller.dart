// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/user_model.dart';
import '../repository/auth_respository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController({
    required this.authRepository,
    required this.ref,
  });

  // Future<UserModel?> getUserData() async {
  //   UserModel? user = await authRepository.getCurrentUserData();
  //   return user;
  // }

  Future<UserModel?> getUserData() async {
    try {
      return await authRepository.getCurrentUserData();
    } catch (e) {
      debugPrint("Error fetching user data: $e");
      return null;
    }
  }

  void signInWithPhoneNumber(
      {required BuildContext context, required String phoneNumber}) {
    authRepository.signInWithPhoneNumber(
        context: context, phoneNumber: phoneNumber);
  }

  void verifyOTP(BuildContext context, String verificationId, String userOTP) {
    authRepository.verifyOTP(
      context: context,
      verificationId: verificationId,
      userOTP: userOTP,
    );
  }

  void saveUserDataToFirebase(
      BuildContext context, String name, File? profilePic) {
    authRepository.saveUserDataToFirebase(
      name: name,
      profilePic: profilePic,
      ref: ref,
      context: context,
    );
  }

  Stream<UserModel> userDataById(String uid) {
    return authRepository.userData(uid);
  }

  void updateUserState(bool isOnline) {
    authRepository.updateUserState(isOnline);
  }
}
