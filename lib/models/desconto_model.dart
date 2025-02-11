class Desconto {
  final double desconto;

  Desconto({required this.desconto});

  factory Desconto.fromJson(Map<String, dynamic> json) {
    return Desconto(desconto: (json['desconto'] ?? 0.0).toDouble());
  }
}
