import 'package:flutter/material.dart';

class SuiteCard extends StatelessWidget {
  final String nome;
  final String imagemUrl;
  final double preco;
  final List<Map<String, String>> categoriaItens;

  const SuiteCard({
    required this.nome,
    required this.imagemUrl,
    required this.preco,
    required this.categoriaItens,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
       width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Imagem da Suíte com restrições
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 250,
                maxWidth: screenWidth,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  width: screenWidth,
                  imagemUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 50),
                ),
              ),
            ),
          ),
                    SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              nome,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[400],
                fontFamily: 'Roboto',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
