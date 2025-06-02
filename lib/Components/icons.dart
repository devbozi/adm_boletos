import 'package:flutter/cupertino.dart';

class CustomCupertinoIcon extends StatelessWidget {
  final Color color;
  final double size;

  const CustomCupertinoIcon({
    super.key,
    this.color = CupertinoColors.black,
    this.size = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      CupertinoIcons.bars,
      color: color,
      size: size,
    );
  }
}



