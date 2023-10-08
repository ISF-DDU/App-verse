import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class WebArchivedBox extends StatelessWidget {
  const WebArchivedBox({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint("Archived tapped");
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: ListTile(
          leading: Icon(
            Remix.inbox_archive_line,
            color: Colors.greenAccent,
          ),
          title: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'Archived',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
