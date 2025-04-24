import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MapScreen> {
  int _selectedIndex = 1; // střední ikona (mapa) je výchozí

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    if (index == 2) {
      // Přejít na user settings screen
      Navigator.pushNamed(context, '/user');
    } else if (index == 1) {
      // Přejít na map screen
      Navigator.pushNamed(context, '/map');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Interaktivní mapa jako placeholder
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/map');
              },
              child: Container(
                height: 200,
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    'Klikni pro mapu',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),

            // Obsah pod mapou
            const Expanded(
              child: Center(
                child: Text(
                  'Obsah domovské stránky',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Domů'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Účet'),
        ],
      ),
    );
  }
}
