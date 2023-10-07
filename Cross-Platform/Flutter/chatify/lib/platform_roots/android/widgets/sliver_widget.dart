import 'package:flutter/material.dart';

class CustomSliver extends StatelessWidget {
  const CustomSliver(
      {required this.child, required this.childCount, super.key});

  final Widget child;
  final int childCount;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          childCount: childCount, (context, index) => child),
    );
  }
}
