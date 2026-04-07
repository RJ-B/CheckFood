import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/di/injection_container.dart';
import '../core/theme/colors.dart';
import '../l10n/generated/app_localizations.dart';
import '../../security/presentation/bloc/auth/auth_bloc.dart';
import '../../security/presentation/bloc/auth/auth_state.dart';
import '../../security/presentation/pages/auth/login_page.dart';
import '../../security/presentation/bloc/user/user_bloc.dart';
import '../../security/presentation/bloc/user/user_event.dart';
import '../../security/presentation/pages/user/profile_screen.dart';
import '../modules/customer/restaurant/presentation/pages/explore_page.dart';
import '../modules/management/my_restaurant/presentation/bloc/my_restaurant_bloc.dart';
import '../modules/management/my_restaurant/presentation/pages/my_restaurant_page.dart';
import '../modules/customer/orders/presentation/bloc/orders_bloc.dart';
import '../modules/customer/orders/presentation/pages/orders_page.dart';
import '../modules/customer/restaurant/presentation/bloc/explore_bloc.dart';
import '../modules/customer/reservation/presentation/bloc/my_reservations_bloc.dart';
import '../modules/customer/reservation/presentation/pages/reservations_screen.dart';

/// Kořenový scaffold zajišťující spodní navigační lištu a stránky hlavních záložek.
///
/// Viditelné záložky se přizpůsobují roli přihlášeného uživatele — personál
/// a majitelé restaurace vidí navíc záložku „Moje restaurace".
class MainShell extends StatefulWidget {
  static final GlobalKey<_MainShellState> shellKey = GlobalKey<_MainShellState>();

  const MainShell({super.key});

  /// Přepne spodní navigační lištu na zadaný [index] z vnějšku widget stromu.
  static void switchToTab(int index) {
    shellKey.currentState?._onTabSelected(index);
  }

  @override
  State<MainShell> createState() => _MainShellState();
}

/// Stav pro [MainShell]: sleduje aktivní index spodní navigace a odvozuje
/// správnou konfiguraci záložek z aktuální role uživatele.
class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  bool _isRestaurantStaff(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    return authState.maybeWhen(
      authenticated: (user) => user.role.isAtLeastEmployee,
      orElse: () => false,
    );
  }

  List<Widget> _buildTabs(bool showMyRestaurant) {
    return [
      BlocProvider(
        create: (context) => sl<ExploreBloc>(),
        child: const ExplorePage(),
      ),
      BlocProvider(
        create: (context) => sl<MyReservationsBloc>(),
        child: const ReservationsScreen(),
      ),
      BlocProvider(
        create: (context) => sl<OrdersBloc>(),
        child: const OrdersPage(),
      ),
      if (showMyRestaurant)
        BlocProvider(
          create: (context) => sl<MyRestaurantBloc>(),
          child: const MyRestaurantPage(),
        ),
      const ProfileScreen(),
    ];
  }

  List<NavigationDestination> _buildDestinations(bool showMyRestaurant, S l) {
    const iconSize = 28.0;
    return [
      NavigationDestination(
        icon: const Icon(Icons.map_outlined, size: iconSize),
        selectedIcon: const Icon(Icons.map, size: iconSize),
        label: '',
      ),
      NavigationDestination(
        icon: const Icon(Icons.calendar_today_outlined, size: iconSize),
        selectedIcon: const Icon(Icons.calendar_today, size: iconSize),
        label: '',
      ),
      NavigationDestination(
        icon: const Icon(Icons.shopping_bag_outlined, size: iconSize),
        selectedIcon: const Icon(Icons.shopping_bag, size: iconSize),
        label: '',
      ),
      if (showMyRestaurant)
        NavigationDestination(
          icon: const Icon(Icons.store_outlined, size: iconSize),
          selectedIcon: const Icon(Icons.store, size: iconSize),
          label: '',
        ),
      NavigationDestination(
        icon: const Icon(Icons.person_outline, size: iconSize),
        selectedIcon: const Icon(Icons.person, size: iconSize),
        label: '',
      ),
    ];
  }

  void _onTabSelected(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeMap(
          unauthenticated: (_) {
            context.read<UserBloc>().add(const UserEvent.clearDataRequested());
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false,
            );
          },
          orElse: () {},
        );
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          final showMyRestaurant = _isRestaurantStaff(context);
          final tabs = _buildTabs(showMyRestaurant);
          final destinations = _buildDestinations(showMyRestaurant, S.of(context));

          final safeIndex = _currentIndex.clamp(0, tabs.length - 1);

          return Scaffold(
            body: IndexedStack(index: safeIndex, children: tabs),
            bottomNavigationBar: NavigationBar(
              height: 64,
              selectedIndex: safeIndex,
              onDestinationSelected: _onTabSelected,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              indicatorColor: AppColors.primary.withValues(alpha: 0.1),
              destinations: destinations,
            ),
          );
        },
      ),
    );
  }
}
