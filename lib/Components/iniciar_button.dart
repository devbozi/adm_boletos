import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const StartButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff95f9c3), Color(0xff539c96), Color(0xff0c0b66)],
          stops: [0, 0, 1],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CupertinoButton(
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 12),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
