import 'dart:convert';

class Boleto {
  String codigo;
  String? valor;
  String? vencimento;
  String? status;

  Boleto({
    required this.codigo,
    this.valor,
    this.vencimento,
    this.status,
  });

  factory Boleto.fromJson(String jsonStr) {
    final json = jsonDecode(jsonStr);
    return Boleto(
      codigo: json['codigo'],
      valor: json['valor'],
      vencimento: json['vencimento'],
      status: json['status'],
    );
  }

  String toJson() {
    return jsonEncode({
      'codigo': codigo,
      'valor': valor,
      'vencimento': vencimento,
      'status': status,
    });
  }
}