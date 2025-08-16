import 'package:adm_boletos/components/colors.dart';
import 'package:flutter/material.dart';

class ColumnDados extends StatefulWidget {
  const ColumnDados({super.key});

  @override
  State<ColumnDados> createState() => _ColumnDadosState();
}

class _ColumnDadosState extends State<ColumnDados> {
  final List<Map<String, dynamic>> dados = [
    {'mes': 'Jan', 'valor': 800.0},
    {'mes': 'Fev', 'valor': 1200.0},
    {'mes': 'Mar', 'valor': 950.0},
    {'mes': 'Abr', 'valor': 1500.0},
    {'mes': 'Mai', 'valor': 1100.0},
    {'mes': 'Jun', 'valor': 700.0},
    {'mes': 'Jul', 'valor': 1300.0},
    {'mes': 'Ago', 'valor': 1000.0},
  ];

  final double fatorEscala = 0.05;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children:
              dados.map((item) {
                double altura = item['valor'] * fatorEscala;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 900),
                        curve: Curves.easeInOut,
                        width: 30,
                        clipBehavior: Clip.hardEdge,
                        height: altura,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)
                          ),
                        ),
                        child: ColorFundoIconTopBotton(),
                      ),
                      SizedBox(height: 8),
                      Text(item['mes']),
                    ],
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
