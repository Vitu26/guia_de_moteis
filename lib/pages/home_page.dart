import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guia_de_moteis/blocs/motel_bloc.dart';
import 'package:guia_de_moteis/blocs/motel_event.dart';
import 'package:guia_de_moteis/blocs/motel_state.dart';
import 'package:guia_de_moteis/controller/home_controller.dart';
import 'package:guia_de_moteis/pages/widgets/custom_appbar.dart';
import 'package:guia_de_moteis/pages/widgets/drawer.dart' as customDrawer;
import 'package:guia_de_moteis/pages/widgets/motel_grid_carousel.dart';
import 'package:guia_de_moteis/pages/widgets/filter_bar.dart';
import 'package:guia_de_moteis/pages/widgets/suite_card.dart';
import 'package:guia_de_moteis/pages/widgets/period_buttom.dart';
import 'package:guia_de_moteis/pages/widgets/icon_wrap.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> filtrosSelecionados = [];
  double minPrice = 30;
  double maxPrice = 2030;

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 160, 24, 15),
      appBar: CustomAppBar(),
      drawer: customDrawer.CustomDrawer(),
      floatingActionButton: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 20,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
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
                          child: BlocBuilder<MotelBloc, MotelState>(
                            builder: (context, state) {
                              final List<String> filtrosSelecionados =
                                  state is MotelLoaded
                                      ? state.filtroSelecionado
                                      : [];

                              return FilterBar(
                                filtros: filtros,
                                filtroSelecionado:
                                    filtrosSelecionados, // Agora sincronizado com o estado do BLoC
                                onFilterSelected:
                                    homeController.handleFilterSelection,
                              );
                            },
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Nenhum motel encontrado para os filtros selecionados.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
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
                                                      suiteNome: suite.nome,
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
