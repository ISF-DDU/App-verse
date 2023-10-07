import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/select_contacts_repository.dart';

final getContactsProvider = FutureProvider((ref) {
  final selectContactsRepository = ref.watch(selectContactsRepositoryProvider);
  return selectContactsRepository.getContactsList();
});

final selectContactControllerProvider = Provider((ref) {
  final selectContactsRepository = ref.watch(selectContactsRepositoryProvider);
  return SelectContactProvider(
      ref: ref, selectContactsRepository: selectContactsRepository);
});

class SelectContactProvider {
  final ProviderRef ref;
  final SelectContactsRepository selectContactsRepository;

  SelectContactProvider(
      {required this.ref, required this.selectContactsRepository});

  void selectContact(Contact selectedContact, BuildContext context) {
    ref
        .read(selectContactsRepositoryProvider)
        .selectContact(selectedContact, context);
  }
}
