import 'package:guia_de_moteis/models/desconto_model.dart';

class Periodo {
  final String tempoFormatado;
  final int tempo;
  final double valor;
  final double valorTotal;
  final bool temCortesia;
  final Desconto? desconto;

  Periodo({
    required this.tempoFormatado,
    required this.tempo,
    required this.valor,
    required this.valorTotal,
    required this.temCortesia,
    this.desconto,
  });

  factory Periodo.fromJson(Map<String, dynamic> json) {
    return Periodo(
      tempoFormatado: json['tempoFormatado'] ?? '',
      tempo: int.tryParse(json['tempo'].toString()) ?? 0,
      valor: (json['valor'] ?? 0.0).toDouble(),
      valorTotal: (json['valorTotal'] ?? 0.0).toDouble(),
      temCortesia: json['temCortesia'] ?? false,
      desconto: json['desconto'] != null ? Desconto.fromJson(json['desconto']) : null,
    );
  }
}
