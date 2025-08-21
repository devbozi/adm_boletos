import 'package:flutter/material.dart';

class GraphWidget extends StatelessWidget {
  final String tipo; // 'pagar', 'pagos', 'vencidos'

  const GraphWidget({super.key, required this.tipo});

  @override
  Widget build(BuildContext context) {
    final alturaTela = MediaQuery.of(context).size.height;
    final larguraTela = MediaQuery.of(context).size.width;

    // Dados mockados por tipo
    final dados = _getDados(tipo);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: larguraTela * 0.05, vertical: alturaTela * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Boletos ${tipo == 'pagar' ? 'a pagar' : tipo == 'pagos' ? 'pagos' : 'vencidos'} por mês',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: alturaTela * 0.25,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: dados.entries.map((entry) {
                final valor = entry.value;
                final alturaBarra = (valor / 1000) * (alturaTela * 0.2); // escala simples

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: larguraTela * 0.06,
                      height: alturaBarra,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(entry.key, style: const TextStyle(fontSize: 12)),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, double> _getDados(String tipo) {
    switch (tipo) {
      case 'pagos':
        return {
          'JAN': 800,
          'FEV': 1200,
          'MAR': 950,
          'ABR': 1100,
          'MAI': 1300,
          'JUN': 900,
          'JUL': 1000,
          'AGO': 1150,
        };
      case 'vencidos':
        return {
          'JAN': 300,
          'FEV': 450,
          'MAR': 500,
          'ABR': 600,
          'MAI': 700,
          'JUN': 650,
          'JUL': 400,
          'AGO': 550,
        };
      default: // 'pagar'
        return {
          'JAN': 1000,
          'FEV': 950,
          'MAR': 1100,
          'ABR': 1050,
          'MAI': 1200,
          'JUN': 980,
          'JUL': 1020,
          'AGO': 990,
        };
    }
  }
}