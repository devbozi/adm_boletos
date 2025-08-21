import 'package:adm_boletos/models/boleto.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> salvarBoleto(Boleto boleto) async {
  final prefs = await SharedPreferences.getInstance();
  final boletos = prefs.getStringList('boletos') ?? [];

  boletos.add(boleto.toJson());
  await prefs.setStringList('boletos', boletos);
}

Future<List<Boleto>> carregarBoletos() async {
  final prefs = await SharedPreferences.getInstance();
  final boletos = prefs.getStringList('boletos') ?? [];

  return boletos.map((json) => Boleto.fromJson(json)).toList();
}