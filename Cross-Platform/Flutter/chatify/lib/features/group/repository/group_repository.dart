// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../common/repositories/common_firebase_storage_repository.dart';
import '../../../common/utils/utils.dart';
import '../../../models/group_model.dart';

final groupRepositoryProvider = Provider(
  (ref) => GroupRepository(
    firebaseAuth: FirebaseAuth.instance,
    firebaseFirestore: FirebaseFirestore.instance,
    ref: ref,
  ),
);

class GroupRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final ProviderRef ref;
  GroupRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.ref,
  });

  void createGroup({
    required BuildContext context,
    required String groupName,
    required File groupProfilePic,
    required List<Contact> selectedContacts,
  }) async {
    try {
      List<String> uids = [];
      for (int i = 0; i < selectedContacts.length; i++) {
        dynamic userDataFirebase = await firebaseFirestore
            .collection('users')
            .where(
              'phoneNumber',
              isEqualTo:
                  selectedContacts[i].phones[0].number.replaceAll(
                        ' ',
                        '',
                      ),
            )
            .get();

        if (userDataFirebase.docs.isNotEmpty &&
            !uids.contains(userDataFirebase.docs[0].data()['uid'])) {
          uids.add(userDataFirebase.docs[0].data()['uid']);
        }
      }

      var groupId = const Uuid().v1();
      String groupPicUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFirebase(
            ref: 'group/$groupId',
            file: groupProfilePic,
          );
      GroupModel group = GroupModel(
        senderId: firebaseAuth.currentUser!.uid,
        name: groupName,
        groupId: groupId,
        lastMessage: "",
        groupProfilePic: groupPicUrl,
        memberUid: [firebaseAuth.currentUser!.uid, ...uids],
        timeSent: DateTime.now(),
      );

      await firebaseFirestore
          .collection('groups')
          .doc(groupId)
          .set(group.toMap());
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
