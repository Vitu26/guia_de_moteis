import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guia_de_moteis/blocs/motel_bloc.dart';
import 'package:guia_de_moteis/blocs/motel_event.dart';
import 'package:guia_de_moteis/blocs/motel_state.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({super.key});

  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  double minPrice = 30;
  double maxPrice = 2030;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MotelBloc, MotelState>(
      builder: (context, state) {
        List<String> filtrosSelecionados =
            state is MotelLoaded ? List.from(state.filtroSelecionado) : [];

        void limparFiltros() {
          setState(() {
            filtrosSelecionados.clear();
          });
          context
              .read<MotelBloc>()
              .add(ApplyFilter(filter: filtrosSelecionados));
        }

        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título do modal
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.angleDown,
                          color: Colors.grey),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "Filtros",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                    ),
                    if (filtrosSelecionados.isNotEmpty)
                      TextButton(
                        onPressed: limparFiltros,
                        child: const Text(
                          'Limpar',
                          style: TextStyle(
                              color: Colors.red, fontFamily: 'Roboto'),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20.0),

                // Faixa de preço
                const Text(
                  "Faixa de preço",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontFamily: 'Roboto'),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.red,
                    inactiveTrackColor: Colors.grey.shade300,
                    thumbColor: Colors.red,
                    overlayColor: Colors.red.withOpacity(0.2),
                    valueIndicatorColor: Colors.red,
                  ),
                  child: RangeSlider(
                    values: RangeValues(minPrice, maxPrice),
                    min: 30,
                    max: 2030,
                    divisions: 200,
                    onChanged: (RangeValues values) {
                      setState(() {
                        minPrice = values.start;
                        maxPrice = values.end;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("R\$ ${minPrice.toInt()}"),
                    Text("R\$ ${maxPrice.toInt()}"),
                  ],
                ),
                const SizedBox(height: 44.0),

                // Períodos
                const Center(
                  child: Text(
                    "Períodos",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        color: Colors.black),
                  ),
                ),
                const SizedBox(height: 22.0),

                Center(
                  child: Wrap(
                    spacing: 12.0,
                    runSpacing: 12.0,
                    alignment: WrapAlignment.center,
                    children: [
                      "1 hora",
                      "2 horas",
                      "3 horas",
                      "4 horas",
                      "5 horas",
                      "6 horas",
                      "7 horas",
                      "8 horas",
                      "9 horas",
                      "10 horas",
                      "11 horas",
                      "12 horas",
                      "perda",
                      "pernoite"
                    ].map((item) {
                      return ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (filtrosSelecionados.contains(item)) {
                              filtrosSelecionados.remove(item);
                            } else {
                              filtrosSelecionados.add(item);
                            }
                          });
                          context
                              .read<MotelBloc>()
                              .add(ApplyFilter(filter: filtrosSelecionados));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: filtrosSelecionados.contains(item)
                              ? Colors.red
                              : Colors.white,
                          foregroundColor: filtrosSelecionados.contains(item)
                              ? Colors.white
                              : Colors.grey,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                              color: filtrosSelecionados.contains(item)
                                  ? Colors.red
                                  : Colors.grey.shade300,
                            ),
                          ),
                        ),
                        child: Text(item,
                            style: const TextStyle(
                                fontSize: 14.0, fontFamily: 'Roboto')),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 44.0),

                // Itens da suíte
                const Center(
                  child: Text(
                    "Itens da suíte",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12.0),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: filtrosDisponiveis.length,
                  itemBuilder: (context, index) {
                    String item = filtrosDisponiveis[index];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (filtrosSelecionados.contains(item)) {
                            filtrosSelecionados.remove(item);
                          } else {
                            filtrosSelecionados.add(item);
                          }
                        });
                        context
                            .read<MotelBloc>()
                            .add(ApplyFilter(filter: filtrosSelecionados));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: filtrosSelecionados.contains(item)
                              ? Colors.red
                              : Colors.white,
                          border: Border.all(
                            color: filtrosSelecionados.contains(item)
                                ? Colors.red
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Text(
                          item,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: filtrosSelecionados.contains(item)
                                ? Colors.white
                                : Colors.grey,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24.0),

                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      context
                          .read<MotelBloc>()
                          .add(ApplyFilter(filter: filtrosSelecionados));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: filtrosSelecionados.isEmpty
                          ? Colors.grey
                          : Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                    ),
                    child: const Text(
                      "VERIFICAR DISPONIBILIDADE",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.white,
                          fontSize: 16.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static const List<String> filtrosDisponiveis = [
    "hidro",
    "piscina",
    "sauna",
    "ofuro",
    "decoracao erotica",
    "decoracao tematica",
    "cadeira erotica",
    "pista de danca",
    "garagem privativa",
    "frigobar",
    "internet wi-fi",
    "suite para festas",
    "suite com acessibilidade"
  ];
}
