import 'package:flutter/material.dart';

class OptionsBars extends StatelessWidget {
  final String text;

  const OptionsBars({
    super.key,
     required this.text,
  }
);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black87,
        border: Border(
          top: BorderSide(color: Colors.black, width: 2),
          bottom: BorderSide(color: Colors.black, width: 1)
        )
      ),
      width: double.infinity,
      child: Align(
        alignment: Alignment.center,
        child: Text(text,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          ),
        ),
      ),
    );
  }
}