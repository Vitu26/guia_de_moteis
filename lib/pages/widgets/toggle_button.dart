import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomToggleButtons extends StatefulWidget {
  @override
  _CustomToggleButtonsState createState() => _CustomToggleButtonsState();
}

class _CustomToggleButtonsState extends State<CustomToggleButtons> {
  bool isNowSelected = true;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isSmallScreen = screenWidth < 400; // Detecta telas menores

    return Container(
      width: isSmallScreen ? screenWidth * 0.75 : 320,
      height: 40, // Altura fixa para evitar distorções
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 106, 17, 10),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              // Botão "Ir Agora"
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (!isNowSelected) {
                      setState(() {
                        isNowSelected = true;
                      });
                    }
                  },
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          LucideIcons.airplay,
                          color: isNowSelected ? Colors.transparent : Colors.white,
                          size: isSmallScreen ? 16 : 20,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'ir agora',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 12 : 14,
                            color: isNowSelected ? Colors.transparent : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Botão "Ir Outro Dia"
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (isNowSelected) {
                      setState(() {
                        isNowSelected = false;
                      });
                    }
                  },
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          LucideIcons.calendar,
                          color: !isNowSelected ? Colors.transparent : Colors.white,
                          size: isSmallScreen ? 16 : 20,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'ir outro dia',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 12 : 14,
                            color: !isNowSelected ? Colors.transparent : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Animação do botão selecionado
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            alignment: isNowSelected ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: isSmallScreen ? screenWidth * 0.35 : 160,
              height: 40, // Ajustado para manter consistência
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: const Color.fromARGB(255, 102, 14, 8),
                  width: 2,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isNowSelected ? LucideIcons.airplay : LucideIcons.calendar,
                      color: Colors.black,
                      size: isSmallScreen ? 14 : 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isNowSelected ? 'ir agora' : 'ir outro dia',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: isSmallScreen ? 12 : 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
