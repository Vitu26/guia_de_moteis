import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:guia_de_moteis/pages/widgets/toggle_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 400;

    return AppBar(
      backgroundColor: const Color.fromARGB(255, 160, 24, 15),
      elevation: 4,
      automaticallyImplyLeading: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      title: Row(
        children: [
          // Ícone do menu (Drawer)
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Scaffold.of(context).openDrawer();
              });
            },
          ),

          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomToggleButtons(),
            ),
          ),

          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {

            },
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Zona Norte",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.white,
                  fontSize: isSmallScreen ? 16 : 18,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
