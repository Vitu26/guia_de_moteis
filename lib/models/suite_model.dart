import 'package:guia_de_moteis/models/categoria_item_model.dart';
import 'package:guia_de_moteis/models/item_model.dart';
import 'package:guia_de_moteis/models/periodo_model.dart';

class Suite {
  final String nome;
  final int quantidade;
  final bool exibirQuantidade;
  final List<String> fotos;
  final List<Item> itens;
  final List<CategoriaItem> categoriaItens;
  final List<Periodo> periodos;

  Suite({
    required this.nome,
    required this.quantidade,
    required this.exibirQuantidade,
    required this.fotos,
    required this.itens,
    required this.categoriaItens,
    required this.periodos,
  });

  factory Suite.fromJson(Map<String, dynamic> json) {
    return Suite(
      nome: json['nome'] ?? '',
      quantidade: json['qtd'] ?? 0,
      exibirQuantidade: json['exibirQtdDisponiveis'] ?? false,
      fotos: (json['fotos'] as List?)?.map((f) => f.toString()).toList() ?? [],
      itens: (json['itens'] as List?)?.map((i) => Item.fromJson(i)).toList() ?? [],
      categoriaItens: (json['categoriaItens'] as List?)?.map((ci) => CategoriaItem.fromJson(ci)).toList() ?? [],
      periodos: (json['periodos'] as List?)?.map((p) => Periodo.fromJson(p)).toList() ?? [],
    );
  }
}
