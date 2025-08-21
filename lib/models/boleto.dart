import 'dart:convert';

class Boleto {
  final String codigo;
  final String? valor;
  final String? vencimento;
  final String? status;

  Boleto({
    required this.codigo,
    this.valor,
    this.vencimento,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'valor': valor,
      'vencimento': vencimento,
      'status': status,
    };
  }

  factory Boleto.fromMap(Map<String, dynamic> map) {
    return Boleto(
      codigo: map['codigo'],
      valor: map['valor'],
      vencimento: map['vencimento'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Boleto.fromJson(String source) => Boleto.fromMap(json.decode(source));
}