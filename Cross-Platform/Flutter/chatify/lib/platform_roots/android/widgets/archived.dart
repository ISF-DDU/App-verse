import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class ArchivedBox extends StatelessWidget {
  final bool isGroup;
  final Function onTap;
  const ArchivedBox({super.key, required this.isGroup, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListTile(
          leading: Icon(
            isGroup ? Remix.team_fill : Remix.inbox_archive_line,
            color: Colors.grey,
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              isGroup ? 'Create Group' : 'Archived',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
