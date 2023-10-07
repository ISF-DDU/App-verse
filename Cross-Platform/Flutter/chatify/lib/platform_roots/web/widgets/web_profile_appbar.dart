import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:chatify/constants/colors.dart';

class WebProfileAppBar extends StatelessWidget {
  const WebProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appBarColor,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: AppBar(
          backgroundColor: appBarColor,
          title: const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://upload.wikimedia.org/wikipedia/commons/8/85/Elon_Musk_Royal_Society_%28crop1%29.jpg"),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Remix.team_fill,
                  color: Colors.grey,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Remix.donut_chart_line,
                  color: Colors.grey,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Remix.message_2_fill,
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
