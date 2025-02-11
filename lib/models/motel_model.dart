import 'package:guia_de_moteis/models/suite_model.dart';

class Motel {
  final String fantasia;
  final String logo;
  final String bairro;
  final double distancia;
  final int favoritos;
  final double media; // Média de avaliações
  final int qtdAvaliacoes; // Total de avaliações
  final List<Suite> suites;
  bool isFavorito; // Estado do favorito

  Motel({
    required this.fantasia,
    required this.logo,
    required this.bairro,
    required this.distancia,
    required this.favoritos,
    required this.media,
    required this.qtdAvaliacoes,
    required this.suites,
    this.isFavorito = false,
  });

  factory Motel.fromJson(Map<String, dynamic> json) {
    return Motel(
      fantasia: json['fantasia'] ?? '',
      logo: json['logo'] ?? '',
      bairro: json['bairro'] ?? '',
      distancia: (json['distancia'] ?? 0.0).toDouble(),
      favoritos: json['qtdFavoritos'] ?? 0,
      media: (json['media'] ?? 0.0).toDouble(), // Trata valores nulos
      qtdAvaliacoes: json['qtdAvaliacoes'] ?? 0, // Trata valores nulos
      suites: (json['suites'] as List?)?.map((s) => Suite.fromJson(s)).toList() ?? [],
      isFavorito: json['isFavorito'] ?? false,
    );
  }
}
