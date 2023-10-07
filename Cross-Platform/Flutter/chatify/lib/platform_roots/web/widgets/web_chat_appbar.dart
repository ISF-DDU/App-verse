import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

import '../../../constants/colors.dart';

class WebChatAppBar extends StatelessWidget {
  const WebChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appBarColor,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: AppBar(
          backgroundColor: appBarColor,
          title: const ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://upload.wikimedia.org/wikipedia/commons/8/85/Elon_Musk_Royal_Society_%28crop1%29.jpg"),
            ),
            title: Text(
              'Reciever\'s name',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              "online",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Remix.more_2_fill,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );
  }
}
