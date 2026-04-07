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

/// Root scaffold that hosts the bottom navigation bar and top-level tab pages.
///
/// The visible tabs adapt to the authenticated user's role: restaurant staff
/// and owners see an additional "My Restaurant" tab.
class MainShell extends StatefulWidget {
  static final GlobalKey<_MainShellState> shellKey = GlobalKey<_MainShellState>();

  const MainShell({super.key});

  /// Switches the bottom navigation bar to the given [index] from outside the widget tree.
  static void switchToTab(int index) {
    shellKey.currentState?._onTabSelected(index);
  }

  @override
  State<MainShell> createState() => _MainShellState();
}

/// State for [MainShell]: tracks the active bottom-nav index and derives the
/// correct tab configuration from the current user role.
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
    return [
      NavigationDestination(icon: const Icon(Icons.search), label: l.explore),
      NavigationDestination(
        icon: const Icon(Icons.calendar_today),
        label: l.myReservations,
      ),
      NavigationDestination(
        icon: const Icon(Icons.shopping_bag),
        label: l.orders,
      ),
      if (showMyRestaurant)
        NavigationDestination(
          icon: const Icon(Icons.store),
          label: l.myRestaurant,
        ),
      NavigationDestination(icon: const Icon(Icons.person), label: l.profile),
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
              height: 80,
              selectedIndex: safeIndex,
              onDestinationSelected: _onTabSelected,
              indicatorColor: AppColors.primary.withValues(alpha: 0.1),
              destinations: destinations,
            ),
          );
        },
      ),
    );
  }
}
