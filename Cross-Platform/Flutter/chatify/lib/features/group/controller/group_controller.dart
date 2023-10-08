// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/group_repository.dart';


final groupControllerProvider = Provider((ref) {
  final groupRepository = ref.read(groupRepositoryProvider);
  return GroupController(
    groupRepository: groupRepository,
    ref: ref,
  );
});

class GroupController {
  final GroupRepository groupRepository;
  final ProviderRef ref;
  GroupController({
    required this.groupRepository,
    required this.ref,
  });

  void createGroup(
      {required BuildContext context,
      required String groupName,
      required File groupProfilePic,
      required List<Contact> selectedContacts}) {
    groupRepository.createGroup(
      context: context,
      groupName: groupName,
      groupProfilePic: groupProfilePic,
      selectedContacts: selectedContacts,
    );
  }
}
