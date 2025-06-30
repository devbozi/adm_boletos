import 'package:flutter/cupertino.dart';

class ColorFundoIcon extends StatelessWidget {
  final Widget? child;
  const ColorFundoIcon({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
       gradient:  LinearGradient(
          colors: [Color(0xff95f9c3), Color(0xff539c96), Color(0xff0c0b66)],
          stops: [0, 0, 1],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        )
      ),
      child: Center(child: child),
    );
  }
}

class ColorFundoIconTopBotton extends StatelessWidget {
  final Widget? child;
  const ColorFundoIconTopBotton({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
       gradient:  LinearGradient(
          colors: [Color(0xff95f9c3), Color(0xff539c96), Color(0xff0c0b66)],
          stops: [0, 0, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
      ),
      child: Center(child: child),
    );
  }
}