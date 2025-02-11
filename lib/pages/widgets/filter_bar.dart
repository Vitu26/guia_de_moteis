import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final List<Map<String, dynamic>> filtros;
  final List<String> filtroSelecionado; // Lista de filtros selecionados
  final Function(String filtro) onFilterSelected;

  const FilterBar({
    required this.filtros,
    required this.filtroSelecionado,
    required this.onFilterSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.5),
      child: Row(
        children: [

          GestureDetector(
            onTap: () => onFilterSelected('filtros'),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 5.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey[300]!),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(1, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.filter_list,
                        size: 18,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        "Filtros",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                if (filtroSelecionado.isNotEmpty)
                  Positioned(
                    top: -5,
                    right: -5,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        '${filtroSelecionado.length}',
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filtros.length - 1, 
              itemBuilder: (context, index) {
                final filtro = filtros[index + 1];
                return GestureDetector(
                  onTap: () => onFilterSelected(filtro['filtro']),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: filtroSelecionado.contains(filtro['filtro'])
                          ? Colors.red
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: filtroSelecionado.contains(filtro['filtro'])
                            ? Colors.red
                            : Colors.grey[300]!,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(1, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        if (filtro['icone'] != null)
                          Icon(
                            filtro['icone'],
                            size: 14.0,
                            color: filtroSelecionado.contains(filtro['filtro'])
                                ? Colors.white
                                : Colors.grey[600],
                          ),
                        const SizedBox(width: 4),
                        Text(
                          filtro['titulo'],
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 12.0,
                            color: filtroSelecionado.contains(filtro['filtro'])
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
