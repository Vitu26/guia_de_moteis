import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconWrap extends StatelessWidget {
  final List<Map<String, String>> categoriaItens;
  final String suiteNome; 
  final List<String> principaisItens; 
  final List<String> outrosItens; 

  const IconWrap({
    required this.categoriaItens,
    required this.suiteNome,
    required this.principaisItens,
    required this.outrosItens,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final int maxIcons = 5; 

    return Container(
      width: screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Expanded(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 8.0,
              runSpacing: 4.0,
              children: categoriaItens.take(maxIcons).map((item) {
                return ClipOval(
                  child: Image.network(
                    item['icone']!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported, size: 24),
                  ),
                );
              }).toList(),
            ),
          ),

          if (categoriaItens.length > maxIcons)
            TextButton(
              onPressed: () {
                showSuiteDetailsModal(
                  context: context,
                  suiteNome: suiteNome,
                  principaisItens: categoriaItens, 
                  outrosItens: outrosItens,
                );
              },
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        "Ver",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "mais",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    FontAwesomeIcons.angleDown,
                    size: 12.0,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

Future<void> showSuiteDetailsModal({
  required BuildContext context,
  required String suiteNome,
  required List<Map<String, String>> principaisItens,
  required List<String> outrosItens,
}) async {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    enableDrag: false,
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            suiteNome.toUpperCase(),
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(FontAwesomeIcons.angleDown),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: ListView(
            children: [
              const Divider(),
              const Center(
                child: Text(
                  "Principais Itens",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              const Divider(),

              Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                alignment: WrapAlignment.center,
                children: principaisItens.map((item) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipOval(
                        child: Image.network(
                          item['icone'] ?? '',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported, size: 40),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        item['nome'] ?? '',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 30.0),
              const Divider(),
              const Center(
                child: Text(
                  "Tem também",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              const Divider(),

              Text(
                outrosItens.join(", "),
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                  height: 1.5,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
