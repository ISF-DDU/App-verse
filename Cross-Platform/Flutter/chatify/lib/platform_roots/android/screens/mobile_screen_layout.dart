// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remixicon/remixicon.dart';

import '../../../common/utils/utils.dart';
import '../../../constants/colors.dart';
import '../../../constants/urls.dart';
import '../../../features/auth/controller/auth_controller.dart';
import '../../../features/chat/widgets/contacts_list.dart';
import '../../../features/contacts/screens/select_contacts_screen.dart';
import '../../../features/group/screens/group_screen.dart';
import '../../../features/status/screens/confirm_status_screen.dart';
import '../../../features/status/screens/status_contacts_screen.dart';

class MobileScreenLayout extends ConsumerStatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  ConsumerState<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends ConsumerState<MobileScreenLayout>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController tabBarController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    tabBarController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
    WidgetsBinding.instance.addObserver(this);
    tabBarController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      currentIndex = tabBarController.index;
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    tabBarController.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).updateUserState(true);
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).updateUserState(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  toolbarHeight: 100,
                  pinned: true,
                  centerTitle: false,
                  floating: true,
                  snap: true,
                  title: const ListTile(
                    title: Text(
                      'Chatify',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 35,
                      ),
                    ),
                    subtitle: Text('Chirp, don\'t be shy'),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, GroupScreen.routeName),
                      icon: const Icon(
                        Remix.group_2_fill,
                        color: tabColor,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: tabColor,
                        size: 30,
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: userProfilePhoto == null
                            ? const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/bot.png'),
                                radius: 30,
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(userProfilePhoto!),
                                radius: 30,
                              )),
                  ],
                  bottom: TabBar(
                    controller: tabBarController,
                    indicatorColor: tabColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: tabColor,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    tabs: const [
                      Tab(
                        text: "Chats",
                      ),
                      Tab(
                        text: 'Status',
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: tabBarController,
            children: [
              Builder(builder: (context) {
                return const MobContactsList();
              }),
              Builder(builder: (context) {
                return const StatusContactsScreen();
              }),
              // Builder(builder: (context) {
              //   return const Center(
              //     child: Text("To Be Implemented"),
              //   );
              // })
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (currentIndex == 0) {
              Navigator.pushNamed(context, SelectContactsScreen.routeName);
            } else if (currentIndex == 1) {
              File? pickedImage = await pickImageFromGallery(context);
              if (pickedImage != null) {
                Navigator.pushNamed(context, ConfirmStatusScreen.routeName,
                    arguments: pickedImage);
              }
            } else {
              debugPrint("To Be Implemented");
            }
          },
          backgroundColor: tabColor,
          child: Icon(
            currentIndex == 0
                ? Icons.comment
                : currentIndex == 1
                    ? Icons.add
                    : Icons.phone,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
