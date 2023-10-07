import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/utils.dart';
import '../../../constants/urls.dart';
import '../controller/group_controller.dart';
import '../widgets/select_contacts_group.dart';

class CreateGroupScreen extends ConsumerStatefulWidget {
  static const String routeName = '/create-group-screen';
  const CreateGroupScreen({super.key});

  @override
  ConsumerState<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends ConsumerState<CreateGroupScreen> {
  final TextEditingController groupNameController = TextEditingController();
  File? image;

  void pickImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void createGroup() {
    if (groupNameController.text.trim().isNotEmpty && image != null) {
      ref.read(groupControllerProvider).createGroup(
            context: context,
            groupName: groupNameController.text.trim(),
            groupProfilePic: image!,
            selectedContacts: ref.read(selectGroupContacts),
          );

      ref.read(selectGroupContacts.notifier).update((state) => []);
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Group'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.05),
          Center(
            child: Stack(
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
          ),
          Container(
            width: size.width * 0.85,
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: groupNameController,
              decoration: const InputDecoration(
                hintText: "Enter Group name",
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Select Contacts',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SelectContactsGroup(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createGroup,
        child: const Icon(Icons.done),
      ),
    );
  }
}
