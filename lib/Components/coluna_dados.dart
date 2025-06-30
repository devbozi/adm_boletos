import 'package:adm_boletos/components/colors.dart';
import 'package:flutter/material.dart';

class ColumnDados extends StatelessWidget {

  const ColumnDados({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 50,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: ColorFundoIconTopBotton(),
    );
  }
}
