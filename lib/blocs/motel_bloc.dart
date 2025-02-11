import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_de_moteis/models/motel_model.dart';
import 'package:guia_de_moteis/repositories/motel_repository.dart';
import 'motel_event.dart';
import 'motel_state.dart';

class MotelBloc extends Bloc<MotelEvent, MotelState> {
  final MotelRepository repository;
  List<Motel> allMoteis = [];

  MotelBloc(this.repository) : super(MotelLoading()) {
    on<LoadMotels>(_onLoadMotels);
    on<ApplyFilter>(_onApplyFilter);
    on<ToggleFavorite>((event, emit) {
      if (state is MotelLoaded) {
        final currentState = state as MotelLoaded;
        final updatedMoteis = currentState.moteis.map((motel) {
          if (motel == event.motel) {
            return Motel(
              fantasia: motel.fantasia,
              logo: motel.logo,
              bairro: motel.bairro,
              distancia: motel.distancia,
              favoritos: motel.favoritos,
              media: motel.media,
              qtdAvaliacoes: motel.qtdAvaliacoes,
              suites: motel.suites,
              isFavorito: !motel.isFavorito, // Alterna o estado de favorito
            );
          }
          return motel;
        }).toList();

        emit(MotelLoaded(moteis: updatedMoteis));
      }
    });
  }

  Future<void> _onLoadMotels(LoadMotels event, Emitter<MotelState> emit) async {
    emit(MotelLoading());
    try {
      final moteis = await repository.fetchMotels();
      allMoteis = moteis; // Guardar todos os motéis carregados
      emit(MotelLoaded(moteis: moteis));
    } catch (e) {
      emit(MotelError(message: "Erro ao carregar motéis: ${e.toString()}"));
    }
  }

  void _onApplyFilter(ApplyFilter event, Emitter<MotelState> emit) {
    if (state is MotelLoaded) {
      final currentState = state as MotelLoaded;
      List<Motel> filteredMoteis = allMoteis;

      // Aplica múltiplos filtros de forma cumulativa
      for (String filter in event.filter) {
        filteredMoteis = _applySingleFilter(filteredMoteis, filter);
      }

      emit(MotelLoaded(moteis: filteredMoteis));
    }
  }

  List<Motel> _applySingleFilter(List<Motel> moteis, String filter) {
    switch (filter) {
      case 'desconto':
        return moteis.where((motel) {
          return motel.suites.any((suite) =>
              suite.periodos.any((periodo) => periodo.desconto != null));
        }).toList();
      case 'disponiveis':
        return moteis.where((motel) {
          return motel.suites.any((suite) => suite.quantidade > 0);
        }).toList();
      case 'hidro':
        return moteis.where((motel) {
          return motel.suites.any((suite) => suite.itens
              .any((item) => item.nome.toLowerCase().contains('hidro')));
        }).toList();
      case 'piscina':
        return moteis.where((motel) {
          return motel.suites.any((suite) => suite.itens
              .any((item) => item.nome.toLowerCase().contains('piscina')));
        }).toList();
      case 'sauna':
        return moteis.where((motel) {
          return motel.suites.any((suite) => suite.itens
              .any((item) => item.nome.toLowerCase().contains('sauna')));
        }).toList();
      case 'ofuro':
        return moteis.where((motel) {
          return motel.suites.any((suite) => suite.itens
              .any((item) => item.nome.toLowerCase().contains('ofuro')));
        }).toList();
      default:
        return moteis;
    }
  }
}
