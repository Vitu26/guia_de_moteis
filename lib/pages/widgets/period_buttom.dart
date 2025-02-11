import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PeriodoButton extends StatelessWidget {
  final String label;
  final double price;
  final VoidCallback onTap;

  const PeriodoButton({
    required this.label,
    required this.price,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth, // Define a largura como a largura da tela
        height: 80.0, // Altura fixa do botão
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        margin: const EdgeInsets.only(bottom: 8.0), // Espaço entre botões
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  Text(
                    "R\$ ${price.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
              Icon(
                FontAwesomeIcons.angleRight,
                color: Colors.grey.shade400,
                size: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
