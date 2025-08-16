import 'package:adm_boletos/components/coluna_dados.dart';
import 'package:adm_boletos/components/gradient_button.dart';
import 'package:adm_boletos/components/texts.dart';
import 'package:flutter/material.dart';

class LowPartApp extends StatelessWidget {
  const LowPartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 29, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    TextPayment(
                      text: 'Total pago esse mes',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    TextPayment(
                      text: r'R$ 23.123,49',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ButtonBorderGradient(),
              ],
            ),
          ),
          SizedBox(height: 25),
          SizedBox(
            height: 2,
            width: double.infinity,
            child: ColoredBox(color: Colors.black12),
          ),
          SizedBox(height: 25),
          Row(
            children: [
              SizedBox(width: 30),
              TextPayment(
                text: 'Seus boletos pagos de 2025',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [ColumnDados()],
          ),
        ],
      ),
    );
  }
}
