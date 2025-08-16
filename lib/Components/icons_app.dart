import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconsApp extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;
  // ignore: non_constant_identifier_names
  final String? cupertinoIcons;

  const IconsApp({
    super.key,
    required this.icon,
    this.size = 40.0,
    // ignore: non_constant_identifier_names
    this.color = Colors.white,
    this.cupertinoIcons,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 28),
        Container(
          width: 53,
          height: 53,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [
                  Color(0xff95f9c3),
                  Color(0xff539c96),
                  Color(0xff0c0b66),
                ],
                stops: [0, 0, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds);
            },
            child: Icon(icon, size: size, color: color),
          ),
        ),
        SizedBox(height: 12),
        Text('PAGAR', style: TextStyle(color: Colors.white, fontSize: 12)),
        SizedBox(height: 35),
      ],
    );
  }
}

class IconsScreen extends StatelessWidget {
  const IconsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 31),
        IconsApp(icon: CupertinoIcons.money_dollar),
        SizedBox(width: 39),
        IconsApp(icon: CupertinoIcons.doc_text),
      ],
    );
  }
}
