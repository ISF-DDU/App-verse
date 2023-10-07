import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remixicon/remixicon.dart';

import '../../../constants/colors.dart';
import '../../../models/user_model.dart';
import '../../auth/controller/auth_controller.dart';
import '../../call/controller/call_controller.dart';
import '../../call/screens/call_pickup_screen.dart';
import '../widgets/bottom_chat_field.dart';
import '../widgets/chat_list.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat-screen';

  final String name;
  final String uid;
  final bool isGroupChat;
  final String recieverProfilePic;
  const MobileChatScreen({
    super.key,
    required this.name,
    required this.uid,
    required this.isGroupChat,
    required this.recieverProfilePic,
  });

  void createCall(WidgetRef ref, BuildContext context) {
    ref.read(callControllerProvider).createCall(
        context: context,
        recieverName: name,
        recieverUid: uid,
        recieverProfilePic: recieverProfilePic,
        isGroupChat: isGroupChat);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CallPickupScreen(
      scaffold: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: isGroupChat
              ? Text(name)
              : StreamBuilder<UserModel>(
                  stream: ref.read(authControllerProvider).userDataById(uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text(name);
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name),
                        Text(
                          snapshot.data!.isOnline ? 'Online' : 'Offline',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    );
                  },
                ),
          titleSpacing: 0,
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () => createCall(ref, context),
              icon: const Icon(Remix.video_add_fill),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Remix.phone_fill),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Remix.more_2_fill),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ChatList(uid, isGroupChat),
            ),
            BottomChatField(
              recieverUserId: uid,
              isGroupChat: isGroupChat,
            ),
          ],
        ),
      ),
    );
  }
}
