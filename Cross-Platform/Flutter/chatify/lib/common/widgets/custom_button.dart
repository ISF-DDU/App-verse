import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  const CustomButton({super.key, required this.text, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: tabColor,
        // shape:
      ),
      onPressed: onPress,
      child: Text(
        text,
        style: const TextStyle(color: blackColor, fontWeight: FontWeight.w600),
      ),
    );
  }
}
