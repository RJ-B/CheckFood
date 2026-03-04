import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/injection_container.dart';
import '../../../../../security/domain/enums/user_role.dart';
import '../../../../../security/presentation/bloc/auth/auth_bloc.dart';
import '../../data/models/request/update_employee_role_request_model.dart';
import '../bloc/my_restaurant_bloc.dart';
import '../bloc/my_restaurant_event.dart';
import '../bloc/my_restaurant_state.dart';
import '../widgets/add_employee_dialog.dart';
import '../widgets/employees_list.dart';
import '../widgets/panorama_tab.dart';
import '../widgets/restaurant_info_form.dart';

import '../../../../management/staff_reservations/presentation/bloc/staff_reservations_bloc.dart';
import '../../../../management/staff_reservations/presentation/pages/staff_reservations_page.dart';

class MyRestaurantPage extends StatefulWidget {
  const MyRestaurantPage({super.key});

  @override
  State<MyRestaurantPage> createState() => _MyRestaurantPageState();
}

class _MyRestaurantPageState extends State<MyRestaurantPage> {
  @override
  void initState() {
    super.initState();
    context.read<MyRestaurantBloc>().add(const LoadMyRestaurant());
  }

  UserRole _getCurrentUserRole(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    return authState.maybeWhen(
      authenticated: (user) => user.role,
      orElse: () => UserRole.user,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyRestaurantBloc, MyRestaurantState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Restaurant'),
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, MyRestaurantState state) {
    if (state is MyRestaurantLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is MyRestaurantError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(state.message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => context.read<MyRestaurantBloc>().add(const LoadMyRestaurant()),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state is MyRestaurantLoaded) {
      final userRole = _getCurrentUserRole(context);
      final isOwner = userRole == UserRole.owner;
      final isManagerOrOwner = userRole.isAtLeastManager;

      final tabs = <Tab>[
        const Tab(icon: Icon(Icons.calendar_today), text: 'Reservations'),
        const Tab(icon: Icon(Icons.info_outline), text: 'Info'),
        if (isManagerOrOwner)
          const Tab(icon: Icon(Icons.people_outline), text: 'Employees'),
        if (isOwner)
          const Tab(icon: Icon(Icons.panorama), text: 'Panorama'),
      ];

      final tabViews = <Widget>[
        // Tab 1: Staff Reservations
        BlocProvider(
          create: (_) => sl<StaffReservationsBloc>(),
          child: const StaffReservationsPage(),
        ),
        // Tab 2: Restaurant Info
        RestaurantInfoForm(
          restaurant: state.restaurant,
          isUpdating: state.isUpdating,
          onSubmit: (request) {
            context.read<MyRestaurantBloc>().add(UpdateRestaurant(request));
          },
        ),
        if (isManagerOrOwner)
          // Tab 3: Employees (manager/owner only)
          _buildEmployeesTab(context, state, isOwner),
        if (isOwner)
          // Tab 4: Panorama (owner only)
          PanoramaTab(activePanoramaUrl: state.restaurant.panoramaUrl),
      ];

      return DefaultTabController(
        length: tabs.length,
        child: Column(
          children: [
            TabBar(tabs: tabs),
            Expanded(
              child: TabBarView(children: tabViews),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildEmployeesTab(BuildContext context, MyRestaurantLoaded state, bool isOwner) {
    return Stack(
      children: [
        EmployeesList(
          employees: state.employees,
          isOwner: isOwner,
          onRoleChanged: (employeeId, newRole) {
            context.read<MyRestaurantBloc>().add(
                  UpdateEmployeeRole(
                    employeeId,
                    UpdateEmployeeRoleRequestModel(role: newRole),
                  ),
                );
          },
          onRemove: (employeeId) {
            context.read<MyRestaurantBloc>().add(RemoveEmployee(employeeId));
          },
        ),
        if (isOwner)
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton.extended(
              onPressed: () => _showAddEmployeeDialog(context),
              icon: const Icon(Icons.person_add),
              label: const Text('Add'),
            ),
          ),
      ],
    );
  }

  void _showAddEmployeeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AddEmployeeDialog(
        onSubmit: (request) {
          context.read<MyRestaurantBloc>().add(AddEmployee(request));
        },
      ),
    );
  }
}
