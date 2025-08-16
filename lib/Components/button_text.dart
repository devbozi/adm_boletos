import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {

  final String text;


  const ButtonText({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      onPressed: () {},
      child: Text(text),
    );
  }
}

class TextsButtonsScreen extends StatelessWidget {
  const TextsButtonsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 31),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ButtonText(text: 'A PAGAR'),
          ButtonText(text: 'TOTAL PAGOS'),
          ButtonText(text: 'VENCIDOS'),
        ],
      ),
    );
  }
}