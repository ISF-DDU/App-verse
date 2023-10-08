// ignore_for_file: public_member_api_docs, sort_constructors_fi
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../models/call_model.dart';
import '../../auth/controller/auth_controller.dart';
import '../repository/call_repository.dart';

final callControllerProvider = Provider((ref) {
  final callRepository = ref.read(callRepositoryProvider);
  return CallController(
    callRepository: callRepository,
    ref: ref,
    firebaseAuth: FirebaseAuth.instance,
  );
});

class CallController {
  final CallRepository callRepository;
  final ProviderRef ref;
  final FirebaseAuth firebaseAuth;
  CallController({
    required this.callRepository,
    required this.ref,
    required this.firebaseAuth,
  });

  Stream<DocumentSnapshot> get callStream => callRepository.callStream;

  void createCall({
    required BuildContext context,
    required String recieverName,
    required String recieverUid,
    required String recieverProfilePic,
    required bool isGroupChat,
  }) {
    ref.read(userDataAuthProvider).whenData((value) {
      String callId = const Uuid().v1();

      CallModel senderCallData = CallModel(
        callerId: firebaseAuth.currentUser!.uid,
        callerName: value!.name,
        callerPic: value.profilePic,
        recieverId: recieverUid,
        recieverName: recieverName,
        recieverPic: recieverProfilePic,
        callId: callId,
        hasDialled: true,
      );

      CallModel recieverCallData = CallModel(
        callerId: firebaseAuth.currentUser!.uid,
        callerName: value.name,
        callerPic: value.profilePic,
        recieverId: recieverUid,
        recieverName: recieverName,
        recieverPic: recieverProfilePic,
        callId: callId,
        hasDialled: false,
      );

      if (isGroupChat) {
        callRepository.createGroupCall(
          senderCallData,
          context,
          recieverCallData,
        );
      } else {
        callRepository.createCall(
            senderCallData: senderCallData,
            recieverCallData: recieverCallData,
            context: context);
      }
    });
  }

  void endCall(String callerId, String recieverId, BuildContext context) {
    callRepository.endCall(
        callerId: callerId, recieverId: recieverId, context: context);
  }

  void endGroupCall(String callerId, String recieverId, BuildContext context) {
    callRepository.endGroupCall(callerId, recieverId, context);
  }
}
