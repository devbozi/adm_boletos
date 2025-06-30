import 'package:flutter/material.dart';

class ButtonBorderGradient extends StatelessWidget {
  const ButtonBorderGradient({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff95f9c3),
            Color(0xff539c96),
            Color(0xff0c0b66),
          ],
          stops: [0, 0, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          onPressed: () {},
          child: Text('Mais detalhes'),
        ),
      ),
    );
  }
}
