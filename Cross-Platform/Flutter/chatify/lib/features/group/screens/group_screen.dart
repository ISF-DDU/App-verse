import 'package:chatify/features/group/screens/create_group_screen.dart';
import 'package:flutter/material.dart';

import '../../../platform_roots/android/widgets/archived.dart';
import 'group_chat_screen.dart';

class GroupScreen extends StatelessWidget {
  static const String routeName = '/group-screen';
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groups'),
      ),
      body: Column(
        children: [
          ArchivedBox(
              isGroup: true,
              onTap: () => Future(
                    () => Navigator.pushNamed(
                        context, CreateGroupScreen.routeName),
                  )),
          const Expanded(child: MobGroupsList()),
        ],
      ),
    );
  }
}
