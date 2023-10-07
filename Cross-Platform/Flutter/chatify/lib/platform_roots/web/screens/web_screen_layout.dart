import 'package:flutter/material.dart';
import 'package:chatify/platform_roots/web/widgets/web_archived.dart';
import 'package:chatify/platform_roots/web/widgets/web_contacts_list.dart';
import 'package:chatify/platform_roots/web/widgets/web_profile_appbar.dart';
import 'package:chatify/platform_roots/web/widgets/web_search_bar.dart';

import '../../../constants/colors.dart';
import '../widgets/web_chat_appbar.dart';
import '../widgets/web_chat_list.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  WebProfileAppBar(),
                  WebSearchBar(),
                  WebArchivedBox(),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.3,
                    indent: 80,
                    // height: 1, //enable if you want no space around divider
                  ),
                  WebContactsList(),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.70,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: const Column(
              children: [
                WebChatAppBar(),
                Expanded(child: WebChatList()),
                TypeBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TypeBox extends StatelessWidget {
  const TypeBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: dividerColor),
        ),
        color: chatBarMessage,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.emoji_emotions_outlined,
              color: Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.attach_file,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 15,
              ),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: searchBarColor,
                  hintText: 'Type a message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(left: 20),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.mic,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
