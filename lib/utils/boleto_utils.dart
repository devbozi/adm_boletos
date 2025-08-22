import 'package:intl/intl.dart';

String calcularStatus(String vencimento) {
  final dataVenc = DateFormat('dd/MM/yyyy').parse(vencimento);
  final hoje = DateTime.now();
  return hoje.isAfter(dataVenc) ? 'vencido' : 'pendente';
}