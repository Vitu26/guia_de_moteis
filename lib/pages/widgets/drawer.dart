import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.85,
      child: Drawer(
        backgroundColor: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red, 
                    Colors.pink, 
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(FontAwesomeIcons.fire, color: Colors.white),
                      Text(
                        'go fidelidade',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Icon(FontAwesomeIcons.angleRight, color: Colors.white),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'acumule selinhos e troque por reservas grátis.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ),

            drawerOption(icon: Icons.login, text: "Login"),
            const SizedBox(height: 12), 
            drawerOption(icon: Icons.help_outline, text: "Ajuda"),
            const SizedBox(height: 12),
            drawerOption(icon: Icons.settings, text: "Configurações"),
            const SizedBox(height: 12),
            drawerOption(icon: Icons.report_problem, text: "Comunicar problema"),
            const SizedBox(height: 12),
            drawerOption(icon: Icons.hotel, text: "Tem um motel? Faça parte"),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'versão 1.0.0',
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Roboto',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget drawerOption({required IconData icon, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), 
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            fontSize: 15, 
          ),
        ),
        trailing: const Icon(FontAwesomeIcons.angleRight, color: Colors.grey), 
        onTap: () {
          // Ação ao tocar
        },
      ),
    );
  }
}
