import 'package:adm_boletos/components/button_text.dart';
import 'package:adm_boletos/components/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextPayment(
              text: 'Boletos a pagar',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            TextPayment(
              text: r'R$ 345.756,87',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            ButtonText(text: 'VER BOLETOS PAGOS'),
          ],
        ),
        Flexible(
          child: Icon(
            CupertinoIcons.chevron_right,
            size: 24,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
