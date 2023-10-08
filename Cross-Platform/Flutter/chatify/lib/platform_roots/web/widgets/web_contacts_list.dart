import 'package:flutter/material.dart';
import 'package:chatify/constants/info.dart';

class WebContactsList extends StatelessWidget {
  const WebContactsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  info[index]['message']!,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
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
            const Divider(
              color: Colors.grey,
              thickness: 0.3,
              indent: 80,
              height: 1,
            )
          ],
        );
      },
    );
  }
}
