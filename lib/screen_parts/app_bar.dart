import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar appBarScreen(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    actions: [
      IconButton(
        icon: Icon(CupertinoIcons.bell, color: Colors.white),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(CupertinoIcons.eye_slash, color: Colors.white),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(CupertinoIcons.bars, color: Colors.white),
        onPressed: () {},
      ),
    ],
  );
}
