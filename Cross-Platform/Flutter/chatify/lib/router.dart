import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chatify/common/widgets/error.dart';
import 'package:chatify/features/auth/screens/login_screen.dart';
import 'package:chatify/features/auth/screens/otp_screen.dart';
import 'package:chatify/features/auth/screens/user_information_screen.dart';
import 'package:chatify/features/contacts/screens/select_contacts_screen.dart';
import 'package:chatify/features/chat/screens/mobile_chat_screen.dart';
import 'package:chatify/features/group/screens/create_group_screen.dart';
import 'package:chatify/features/group/screens/group_screen.dart';
import 'package:chatify/features/status/screens/confirm_status_screen.dart';
import 'package:chatify/features/status/screens/status_screen.dart';
import 'package:chatify/models/status_model.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());

    case OPTScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => OPTScreen(
                verificationId: verificationId,
              ));

    case UserInformationScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const UserInformationScreen());

    case SelectContactsScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const SelectContactsScreen());

    case MobileChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      final isGroupChat = arguments['isGroupChat'];
      final recieverProfilePic = arguments['recieverProfilePic'];
      return MaterialPageRoute(
        builder: (context) => MobileChatScreen(
          name: name,
          uid: uid,
          isGroupChat: isGroupChat,
          recieverProfilePic: recieverProfilePic,
        ),
      );

    case ConfirmStatusScreen.routeName:
      final File file = settings.arguments as File;
      return MaterialPageRoute(
          builder: (context) => ConfirmStatusScreen(
                file: file,
              ));

    case StatusScreen.routeName:
      final status = settings.arguments as Status;
      return MaterialPageRoute(
          builder: (context) => StatusScreen(
                status: status,
              ));

    case CreateGroupScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const CreateGroupScreen(),
      );

    case GroupScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const GroupScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: "This page doesn't exists"),
        ),
      );
  }
}
