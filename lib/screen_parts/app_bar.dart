import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(126.0);
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 20, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.bell, size: 24, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(CupertinoIcons.eye_slash, size: 24, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(CupertinoIcons.bars, size: 24, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
