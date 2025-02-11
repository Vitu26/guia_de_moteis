import 'package:equatable/equatable.dart';
import 'package:guia_de_moteis/models/motel_model.dart';

abstract class MotelState extends Equatable {
  @override
  List<Object> get props => [];
}

class MotelLoading extends MotelState {}

class MotelLoaded extends MotelState {
  final List<Motel> moteis;
  final List<String> filtroSelecionado; // Adicionado aqui

  MotelLoaded({
    required this.moteis,
    this.filtroSelecionado = const [], // Inicialização com lista vazia
  });

  @override
  List<Object> get props => [moteis, filtroSelecionado];
}


class MotelError extends MotelState {
  final String message;

  MotelError({required this.message});

  @override
  List<Object> get props => [message];
}
