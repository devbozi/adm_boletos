import 'package:adm_boletos/components/colors.dart';
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
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    TextPayment(
                      text: 'Total pago esse mes',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    TextPayment(
                      text: r'R$ 23.123,49',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ButtonBorderGradient(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ColumnDados(),
              ColumnDados(),
              ColumnDados(),
              ColumnDados(),
              ColumnDados(),
              ColumnDados(),
              ColumnDados(),
              ColumnDados(),
            ],
          ),
        ],
      ),
    );
  }
}