import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guia_de_moteis/blocs/motel_bloc.dart';
import 'package:guia_de_moteis/blocs/motel_event.dart';
import 'package:guia_de_moteis/blocs/motel_state.dart';
import 'package:guia_de_moteis/pages/widgets/filter_modal.dart';

class HomeController {
  double minPrice = 30;
  double maxPrice = 2030;

  final BuildContext context;

  HomeController(this.context);

  void handleFilterSelection(String filtro) {
    final motelBloc = context.read<MotelBloc>();
    final estadoAtual = motelBloc.state;

    if (estadoAtual is MotelLoaded) {
      List<String> filtrosAtuais = List.from(estadoAtual.filtroSelecionado);

      if (filtro == 'filtros') {
        abrirModalFiltros();
      } else {
        if (filtrosAtuais.contains(filtro)) {
          filtrosAtuais.remove(filtro);
        } else {
          filtrosAtuais.add(filtro);
        }

        motelBloc.add(ApplyFilter(filter: filtrosAtuais));
      }
    }
  }
  void abrirModalFiltros() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (BuildContext context) {
        return const FilterModal();
      },
    );
  }
}