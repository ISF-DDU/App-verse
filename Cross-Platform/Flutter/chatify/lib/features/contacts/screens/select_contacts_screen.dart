import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remixicon/remixicon.dart';

import '../../../common/widgets/error.dart';
import '../../../common/widgets/loader.dart';
import '../controller/get_contacts_provider.dart';

class SelectContactsScreen extends ConsumerWidget {
  static const String routeName = '/select-contact-screen';
  const SelectContactsScreen({super.key});

  void selectContact(
      WidgetRef ref, Contact selectedContact, BuildContext context) {
    ref
        .read(selectContactControllerProvider)
        .selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Contacts'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Remix.search_2_line),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Remix.more_2_fill),
          ),
        ],
      ),
      body: ref.watch(getContactsProvider).when(
          data: (contacts) {
            return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  Contact contact = contacts[index];
                  return InkWell(
                    onTap: () => selectContact(ref, contact, context),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        leading: contact.photo == null
                            ? null
                            : CircleAvatar(
                                backgroundImage: MemoryImage(contact.photo!),
                                radius: 30,
                              ),
                        title: Text(
                          contact.displayName,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  );
                });
          },
          error: ((error, stackTrace) => ErrorScreen(error: error.toString())),
          loading: () => const Loader()),
    );
  }
}
