import 'package:intl/intl.dart';

String calcularStatus(String vencimento) {
  final dataVenc = DateFormat('dd/MM/yyyy').parse(vencimento);
  final hoje = DateTime.now();
  return hoje.isAfter(dataVenc) ? 'vencido' : 'pendente';
}

String reconstruirCodigoDeBarras(String linhaReconstruida) {
  final limpa = linhaReconstruida.replaceAll(RegExp(r'\D'), '');

  if (limpa.length != 47) return limpa;

  final campo1 = limpa.substring(0, 9);     // 9 dígitos
  final campo2 = limpa.substring(10, 20);   // 10 dígitos
  final campo3 = limpa.substring(21, 31);   // 10 dígitos
  final campo4 = limpa.substring(32, 47);   // 15 dígitos
  final dv = limpa.substring(9, 10);        // dígito verificador geral

  // Código de barras: banco + moeda + DV + vencimento + valor + campo livre
  return campo1.substring(0, 4) + // banco + moeda
         dv +                     // dígito verificador
         campo4 +                 // vencimento + valor
         campo1.substring(4, 9) + // campo livre parte 1
         campo2 +                 // campo livre parte 2
         campo3;                  // campo livre parte 3
}

