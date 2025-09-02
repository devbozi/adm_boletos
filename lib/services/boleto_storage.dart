import 'package:shared_preferences/shared_preferences.dart';
import '../models/boleto.dart';

Future<void> salvarBoleto(Boleto boleto) async {
  final prefs = await SharedPreferences.getInstance();
  final lista = prefs.getStringList('boletos') ?? [];

  // Limpa espaços e quebras de linha do código de barras
  boleto.codigo = boleto.codigo.replaceAll(RegExp(r'\s+'), '');

  lista.removeWhere((json) {
    final existente = Boleto.fromJson(json);
    return existente.codigo == boleto.codigo;
  });

  lista.add(boleto.toJson());
  await prefs.setStringList('boletos', lista);
}


Future<List<Boleto>> carregarBoletos() async {
  final prefs = await SharedPreferences.getInstance();
  final lista = prefs.getStringList('boletos') ?? [];
  return lista.map((json) => Boleto.fromJson(json)).toList();
} 