import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

import '../../../constants/colors.dart';

class WebSearchBar extends StatelessWidget {
  const WebSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.25,
          padding: const EdgeInsets.all(10),
          child: TextField(
            cursorColor: Colors.white,
            decoration: InputDecoration(
              filled: true,
              fillColor: appBarColor,
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(Icons.search, size: 20),
              ),
              hintStyle: const TextStyle(fontSize: 14),
              hintText: 'Search or start new chat',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              contentPadding: const EdgeInsets.all(10),
            ),
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Remix.filter_3_line,
              color: Colors.grey,
            ))
      ],
    );
  }
}
