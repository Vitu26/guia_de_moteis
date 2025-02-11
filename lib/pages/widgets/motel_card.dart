import 'package:flutter/material.dart';
import 'package:guia_de_moteis/models/motel_model.dart';

class MotelCard extends StatelessWidget {
  final Motel motel;

  const MotelCard({Key? key, required this.motel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    motel.logo,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported, size: 50);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    motel.fantasia,
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(motel.bairro),
            const SizedBox(height: 8),
            Text("Distância: ${motel.distancia.toStringAsFixed(2)} km"),
            const SizedBox(height: 8),
            Text("Favoritos: ${motel.favoritos}"),
          ],
        ),
      ),
    );
  }
}
