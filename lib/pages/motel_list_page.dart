import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guia_de_moteis/blocs/motel_bloc.dart';
import 'package:guia_de_moteis/blocs/motel_event.dart';
import 'package:guia_de_moteis/blocs/motel_state.dart';
import 'package:guia_de_moteis/pages/widgets/custom_appbar.dart';
import 'package:guia_de_moteis/pages/widgets/drawer.dart' as customDrawer;
import 'package:guia_de_moteis/pages/widgets/motel_grid_carousel.dart';
import 'package:guia_de_moteis/pages/widgets/filter_bar.dart';
import 'package:guia_de_moteis/pages/widgets/suite_card.dart';
import 'package:guia_de_moteis/pages/widgets/period_buttom.dart';
import 'package:guia_de_moteis/pages/widgets/icon_wrap.dart';

class MotelListPage extends StatefulWidget {
  @override
  _MotelListPageState createState() => _MotelListPageState();
}

class _MotelListPageState extends State<MotelListPage> {
  List<String> filtrosSelecionados = []; // Gerencia os filtros selecionados

  void handleFilterSelection(String filtro) {
    if (filtro == 'filtros') {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Sem bordas arredondadas
        ),
        builder: (BuildContext context) {
          double minPrice = 30;
          double maxPrice = 2030;

          return StatefulBuilder(
            builder: (context, setState) {
              bool hasFilters = filtrosSelecionados.isNotEmpty;

              void limparFiltros() {
                setState(() {
                  filtrosSelecionados.clear();
                  minPrice = 30;
                  maxPrice = 2030;
                });
              }

              return Container(
                height: MediaQuery.of(context).size.height * 0.9, // 90% da tela
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 24.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Cabeçalho
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
                          if (hasFilters)
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

                      // Faixa de Preço
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
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    filtrosSelecionados.contains(item)
                                        ? Colors.red
                                        : Colors.white,
                                foregroundColor:
                                    filtrosSelecionados.contains(item)
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
                              child: Text(
                                item,
                                style: const TextStyle(
                                    fontSize: 14.0, fontFamily: 'Roboto'),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 44.0),

                      // Toggles
                      SwitchListTile(
                        activeColor: Colors.red,
                        title: const Text("Somente suítes com desconto"),
                        value: filtrosSelecionados.contains("desconto"),
                        onChanged: (bool value) {
                          setState(() {
                            if (value) {
                              filtrosSelecionados.add("desconto");
                            } else {
                              filtrosSelecionados.remove("desconto");
                            }
                          });
                        },
                      ),
                      SwitchListTile(
                        activeColor: Colors.red,
                        title: const Text("Somente suítes disponíveis"),
                        value: filtrosSelecionados.contains("disponiveis"),
                        onChanged: (bool value) {
                          setState(() {
                            if (value) {
                              filtrosSelecionados.add("disponiveis");
                            } else {
                              filtrosSelecionados.remove("disponiveis");
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 24.0),

                      // Itens da Suíte
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 4,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: 13,
                        itemBuilder: (context, index) {
                          List<String> opcoes = [
                            "Hidro",
                            "Piscina",
                            "Sauna",
                            "Ofurô",
                            "Decoração Erótica",
                            "Decoração Temática",
                            "Cadeira Erótica",
                            "Pista de Dança",
                            "Garagem Privativa",
                            "Frigobar",
                            "Internet Wi-Fi",
                            "Suíte para Festas",
                            "Suíte com Acessibilidade"
                          ];

                          String item = opcoes[index];

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filtrosSelecionados.contains(item)) {
                                  filtrosSelecionados.remove(item);
                                } else {
                                  filtrosSelecionados.add(item);
                                }
                              });
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

                      // Botão de Verificar Disponibilidade
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: ElevatedButton(
                          onPressed: filtrosSelecionados.isEmpty
                              ? null
                              : () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: filtrosSelecionados.isEmpty
                                ? Colors.grey
                                : Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 18.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                          ),
                          child: const Text("VERIFICAR DISPONIBILIDADE",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.white,
                                  fontSize: 16.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 160, 24, 15),
      appBar: CustomAppBar(),
      drawer: customDrawer.CustomDrawer(),
      floatingActionButton: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 20, // Ajuste para alinhar na parte inferior
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 40, // Altura do botão
                width: MediaQuery.of(context).size.width *
                    0.2, // Largura proporcional à tela
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(20), // Bordas arredondadas
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Mapa",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: BlocBuilder<MotelBloc, MotelState>(
          builder: (context, state) {
            final filtros = [
              {
                'titulo': 'Filtros',
                'filtro': 'filtros',
                'icone': Icons.filter_list
              },
              {'titulo': 'Com desconto', 'filtro': 'desconto'},
              {'titulo': 'Disponíveis', 'filtro': 'disponiveis'},
              {'titulo': 'Hidro', 'filtro': 'hidro'},
              {'titulo': 'Piscina', 'filtro': 'piscina'},
              {'titulo': 'Sauna', 'filtro': 'sauna'},
              {'titulo': 'Ofurô', 'filtro': 'ofuro'},
            ];

            final carrosselItens = state is MotelLoaded
                ? context.read<MotelBloc>().allMoteis.expand((motel) {
                    return motel.suites.map((suite) {
                      return {
                        'imagem':
                            suite.fotos.isNotEmpty ? suite.fotos.first : '',
                        'titulo': motel.fantasia,
                        'localizacao': motel.bairro,
                      };
                    }).toList();
                  }).toList()
                : [];

            return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        if (carrosselItens.isNotEmpty)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: MotelGridCarousel(
                              itens:
                                  carrosselItens.cast<Map<String, dynamic>>(),
                            ),
                          ),
                        const SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: FilterBar(
                            filtros: filtros,
                            filtroSelecionado: filtrosSelecionados,
                            onFilterSelected: handleFilterSelection,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ];
              },
              body: state is MotelLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state is MotelError
                      ? Center(child: Text(state.message))
                      : state is MotelLoaded && state.moteis.isEmpty
                          ? const Center(
                              child: Text(
                                "Nenhum motel encontrado para os filtros selecionados.",
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16.0,
                                    color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              itemCount: (state as MotelLoaded).moteis.length,
                              itemBuilder: (context, index) {
                                final motel = state.moteis[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 5.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 25,
                                                backgroundColor:
                                                    Colors.grey[200],
                                                backgroundImage: motel
                                                        .logo.isNotEmpty
                                                    ? NetworkImage(motel.logo)
                                                    : null,
                                                child: motel.logo.isEmpty
                                                    ? const Icon(Icons.hotel,
                                                        size: 20,
                                                        color: Colors.grey)
                                                    : null,
                                              ),
                                              const SizedBox(width: 10.0),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    motel.fantasia,
                                                    style: const TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    motel.bairro,
                                                    style: const TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 14.0),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .yellow),
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                                size: 16.0),
                                                            Text(
                                                              "${motel.media.toStringAsFixed(1)}",
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  fontSize:
                                                                      12.0),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 6,
                                                      ),
                                                      Text(
                                                          "${motel.qtdAvaliacoes} avaliações"),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              motel.isFavorito
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: motel.isFavorito
                                                  ? Colors.red
                                                  : Colors.grey,
                                            ),
                                            onPressed: () {
                                              context
                                                  .read<MotelBloc>()
                                                  .add(ToggleFavorite(motel));
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8.0),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: motel.suites.map((suite) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  minWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.8,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SuiteCard(
                                                      nome: suite.nome,
                                                      imagemUrl:
                                                          suite.fotos.first,
                                                      preco: suite.periodos
                                                          .first.valorTotal,
                                                      categoriaItens: suite
                                                          .categoriaItens
                                                          .map((item) {
                                                        return {
                                                          'nome': item.nome,
                                                          'icone': item.icone,
                                                        };
                                                      }).toList(),
                                                    ),
                                                    const SizedBox(height: 8.0),
                                                    IconWrap(
                                                      categoriaItens: suite
                                                          .categoriaItens
                                                          .map((item) => {
                                                                'icone':
                                                                    item.icone
                                                              })
                                                          .toList(),
                                                      suiteNome: suite
                                                          .nome, // Nome da suíte
                                                      principaisItens: suite
                                                          .itens
                                                          .map((item) =>
                                                              item.nome)
                                                          .toList(),
                                                      outrosItens: suite
                                                          .categoriaItens
                                                          .map((item) =>
                                                              item.nome)
                                                          .toList(),
                                                    ),
                                                    const SizedBox(height: 8.0),
                                                    ...suite.periodos
                                                        .map((periodo) {
                                                      return PeriodoButton(
                                                        label:
                                                            "${periodo.tempoFormatado} horas",
                                                        price:
                                                            periodo.valorTotal,
                                                        onTap: () {},
                                                      );
                                                    }).toList(),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
            );
          },
        ),
      ),
    );
  }
}
