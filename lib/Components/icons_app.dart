import 'package:flutter/material.dart';

class IconsApp extends StatelessWidget {

  final IconData icon;
  final double? size;
  final Color? color;
  // ignore: non_constant_identifier_names
  final String? CupertinoIcons;

  const IconsApp({
    super.key,
     required this.icon,
       this.size = 45.0,
         // ignore: non_constant_identifier_names
         this.color = Colors.white, this.CupertinoIcons,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        Container(
          width: 50,
          height: 50,
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
            child: Icon(
              icon,
              size: size,
              color: color,
            ),
          ),
        ),
        Text(
          'PAGAR',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}