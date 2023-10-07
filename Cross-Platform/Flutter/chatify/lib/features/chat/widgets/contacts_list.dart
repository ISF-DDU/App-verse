import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../common/widgets/loader.dart';
import '../../../models/chat_model.dart';
import '../../../platform_roots/android/widgets/archived.dart';
import '../controllers/chat_controller.dart';
import '../screens/mobile_chat_screen.dart';

class MobContactsList extends ConsumerWidget {
  const MobContactsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<ChatContact>>(
      stream: ref.watch(chatControllerProvider).chatContacts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }
        return CustomScrollView(
          slivers: [
            SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var chatContactData = snapshot.data![index];
                  debugPrint("hello");
                  return Column(
                    children: [
                      index == 0
                          ? ArchivedBox(
                              isGroup: false,
                              onTap: () {},
                            )
                          : Container(),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, MobileChatScreen.routeName,
                              arguments: {
                                'name': chatContactData.name,
                                'uid': chatContactData.contactId,
                                'isGroupChat': false,
                                'recieverProfilePic':
                                    chatContactData.profilePic,
                              });
                        },
                        child: ListTile(
                          leading: chatContactData.profilePic != ""
                              ? CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(chatContactData.profilePic),
                                  radius: 30,
                                )
                              : const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/bot.png'),
                                  radius: 30,
                                ),
                          title: Text(
                            chatContactData.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            chatContactData.lastMessage,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          trailing: Text(
                            DateFormat.Hm().format(chatContactData.timeSent),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                childCount: snapshot.data!.length,
              ),
            ),
          ],
        );
      },
    );
  }
}

/*
Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: info.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              InkWell(
                onTap: () {},
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(info[index]['profilePic']!),
                    radius: 30,
                  ),
                  title: Text(
                    info[index]['name']!,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    info[index]['message']!,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  trailing: Text(
                    info[index]['time']!,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
*/
