import 'package:flutter/cupertino.dart';

class TextPayment extends StatelessWidget {
  final String? text;
  final TextStyle? style;

  const TextPayment({super.key, this.text, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: style,
    );
  }
}
