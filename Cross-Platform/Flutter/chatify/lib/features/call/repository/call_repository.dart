// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/utils.dart';
import '../../../models/call_model.dart';
import '../../../models/group_model.dart';
import '../screens/call_screen.dart';

final callRepositoryProvider = Provider(
  (ref) => CallRepository(
    firebaseAuth: FirebaseAuth.instance,
    firebaseFirestore: FirebaseFirestore.instance,
  ),
);

class CallRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  CallRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  Stream<DocumentSnapshot> get callStream => firebaseFirestore
      .collection('calls')
      .doc(firebaseAuth.currentUser!.uid)
      .snapshots();

  void createCall({
    required CallModel senderCallData,
    required CallModel recieverCallData,
    required BuildContext context,
  }) async {
    try {
      await firebaseFirestore
          .collection('calls')
          .doc(senderCallData.callerId)
          .set(
            senderCallData.toMap(),
          );

      await firebaseFirestore
          .collection('calls')
          .doc(senderCallData.recieverId)
          .set(
            recieverCallData.toMap(),
          );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallScreen(
            channelId: senderCallData.callId,
            call: senderCallData,
            isGroupChat: false,
          ),
        ),
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void createGroupCall(
    CallModel senderCallData,
    BuildContext context,
    CallModel receiverCallData,
  ) async {
    try {
      await firebaseFirestore
          .collection('calls')
          .doc(senderCallData.callerId)
          .set(senderCallData.toMap());

      var groupSnapshot = await firebaseFirestore
          .collection('groups')
          .doc(senderCallData.recieverId)
          .get();
      GroupModel group = GroupModel.fromMap(groupSnapshot.data()!);

      for (var id in group.memberUid) {
        await firebaseFirestore
            .collection('calls')
            .doc(id)
            .set(receiverCallData.toMap());
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallScreen(
            channelId: senderCallData.callId,
            call: senderCallData,
            isGroupChat: true,
          ),
        ),
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void endCall({
    required String callerId,
    required String recieverId,
    required BuildContext context,
  }) async {
    try {
      await firebaseFirestore.collection('calls').doc(callerId).delete();

      await firebaseFirestore.collection('calls').doc(recieverId).delete();
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void endGroupCall(
    String callerId,
    String receiverId,
    BuildContext context,
  ) async {
    try {
      await firebaseFirestore.collection('calls').doc(callerId).delete();
      var groupSnapshot =
          await firebaseFirestore.collection('groups').doc(receiverId).get();
      GroupModel group = GroupModel.fromMap(groupSnapshot.data()!);
      for (var id in group.memberUid) {
        await firebaseFirestore.collection('calls').doc(id).delete();
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
