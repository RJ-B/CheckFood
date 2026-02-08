import 'package:checkfood_client/security/presentation/pages/user/profile_screen.dart';
import 'package:flutter/material.dart';
import '../core/theme/colors.dart';

// Importy jednotlivých obrazovek (Features)
import '../features/explore/presentation/explore_screen.dart';
import '../features/reservations/reservations_screen.dart';
import '../features/orders/orders_screen.dart';
import '../features/favorites/favorites_screen.dart';

/// Hlavní kontejner aplikace po úspěšném přihlášení.
/// Obsahuje spodní navigační lištu a spravuje životní cyklus hlavních záložek.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  // Seznam stránek, které jsou neustále v paměti díky IndexedStack
  final List<Widget> _tabs = const [
    ExploreScreen(),
    ReservationsScreen(),
    OrdersScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  void _onTabSelected(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack udržuje stav všech tabů (scroll pozice, data ve formulářích)
      body: IndexedStack(index: _currentIndex, children: _tabs),
      bottomNavigationBar: NavigationBar(
        height: 80,
        selectedIndex: _currentIndex,
        onDestinationSelected: _onTabSelected,
        indicatorColor: AppColors.primary.withOpacity(0.1),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.search), label: 'Explore'),
          NavigationDestination(
            icon: Icon(Icons.calendar_today),
            label: 'Reservations',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_bag),
            label: 'Orders',
          ),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Favorites'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
