import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../l10n/generated/app_localizations.dart';

import '../../../../../../core/di/injection_container.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../security/domain/enums/user_role.dart';
import '../../../../../../security/presentation/bloc/auth/auth_bloc.dart';
import '../../data/models/request/update_employee_role_request_model.dart';
import '../bloc/my_restaurant_bloc.dart';
import '../bloc/my_restaurant_event.dart';
import '../bloc/my_restaurant_state.dart';
import '../widgets/add_employee_dialog.dart';
import '../../domain/entities/employee.dart';
import '../widgets/employee_permissions_dialog.dart';
import '../widgets/employees_list.dart';
import '../widgets/restaurant_info_form.dart';
import '../widgets/statistics_tab.dart';

import '../../../../../reservation/presentation/staff/presentation/bloc/staff_reservations_bloc.dart';
import '../../../../../reservation/presentation/staff/presentation/bloc/staff_reservations_event.dart';
import '../../../../../reservation/presentation/staff/presentation/pages/staff_reservations_page.dart';

/// Dashboard page majitele/manažera poskytující záložky pro rezervace, zaměstnance,
/// statistiky a nastavení restaurace se stráží neuložených změn na záložce nastavení.
class MyRestaurantPage extends StatefulWidget {
  const MyRestaurantPage({super.key});

  @override
  State<MyRestaurantPage> createState() => _MyRestaurantPageState();
}

class _MyRestaurantPageState extends State<MyRestaurantPage> {
  bool _hasUnsavedChanges = false;

  @override
  void initState() {
    super.initState();
    context.read<MyRestaurantBloc>().add(const LoadMyRestaurant());
  }

  /// Zobrazí potvrzovací dialog, když se uživatel pokusí odejít s neuloženými změnami.
  /// Vrátí true, pokud chce uživatel pokračovat (zahodit nebo uložit), false pro zůstání.
  Future<bool> _confirmUnsavedChanges(BuildContext context) async {
    if (!_hasUnsavedChanges) return true;
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Neuložené změny'),
        content: const Text('Máte neuložené změny v nastavení. Co chcete udělat?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, 'stay'),
            child: const Text('Zůstat'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, 'discard'),
            child: Text('Zahodit', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
    if (result == 'discard') {
      _hasUnsavedChanges = false;
      return true;
    }
    return false;
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
    return BlocConsumer<MyRestaurantBloc, MyRestaurantState>(
      listenWhen: (prev, curr) {
        if (prev is MyRestaurantLoaded && curr is MyRestaurantLoaded) {
          return prev.isUpdating && !curr.isUpdating
              && prev.selectedRestaurantId == curr.selectedRestaurantId;
        }
        return false;
      },
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Změny byly uloženy.'),
            backgroundColor: AppColors.success,
            duration: Duration(seconds: 2),
          ),
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).myRestaurant),
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
            const Icon(Icons.error_outline, size: 64, color: AppColors.error),
            const SizedBox(height: 16),
            Text(state.message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => context.read<MyRestaurantBloc>().add(const LoadMyRestaurant()),
              icon: const Icon(Icons.refresh),
              label: Text(S.of(context).retry),
            ),
          ],
        ),
      );
    }

    if (state is MyRestaurantLoaded) {
      final userRole = _getCurrentUserRole(context);
      final isOwner = userRole == UserRole.owner;
      final isManagerOrOwner = userRole.isAtLeastManager;

      final l = S.of(context);
      final tabs = <Tab>[
        const Tab(icon: Icon(Icons.calendar_today, size: 26)),
        if (isManagerOrOwner)
          const Tab(icon: Icon(Icons.people_outline, size: 26)),
        if (isManagerOrOwner)
          const Tab(icon: Icon(Icons.bar_chart, size: 26)),
        const Tab(icon: Icon(Icons.settings, size: 26)),
      ];

      final tabViews = <Widget>[
        BlocProvider(
          create: (_) => sl<StaffReservationsBloc>(),
          child: BlocListener<MyRestaurantBloc, MyRestaurantState>(
            listenWhen: (prev, curr) {
              if (prev is MyRestaurantLoaded && curr is MyRestaurantLoaded) {
                return prev.selectedRestaurantId != curr.selectedRestaurantId;
              }
              return false;
            },
            listener: (context, myState) {
              if (myState is MyRestaurantLoaded) {
                context.read<StaffReservationsBloc>().add(
                  LoadStaffReservations(
                    context.read<StaffReservationsBloc>().state.selectedDate,
                    restaurantId: myState.selectedRestaurantId,
                  ),
                );
              }
            },
            child: const StaffReservationsPage(),
          ),
        ),
        if (isManagerOrOwner)
          _buildEmployeesTab(context, state, isOwner),
        if (isManagerOrOwner)
          StatisticsTab(
            employeeCount: state.employees.length,
            isActive: state.restaurant.isActive,
            hasPanorama: state.restaurant.panoramaUrl != null,
          ),
        RestaurantInfoForm(
          restaurant: state.restaurant,
          isUpdating: state.isUpdating,
          isOwner: isOwner,
          onSubmit: (request) {
            context.read<MyRestaurantBloc>().add(UpdateRestaurant(request));
          },
          onDirtyChanged: (dirty) => _hasUnsavedChanges = dirty,
        ),
      ];

      return DefaultTabController(
        length: tabs.length,
        child: Builder(
          builder: (context) {
            final tabController = DefaultTabController.of(context);
            final settingsTabIndex = tabs.length - 1;
            tabController.addListener(() {
              FocusScope.of(context).unfocus();
              if (tabController.previousIndex == settingsTabIndex &&
                  tabController.index != settingsTabIndex &&
                  _hasUnsavedChanges) {
                final targetIndex = tabController.index;
                tabController.index = settingsTabIndex;
                _confirmUnsavedChanges(context).then((proceed) {
                  if (proceed && context.mounted) {
                    tabController.animateTo(targetIndex);
                  }
                });
              }
            });
            return Column(
          children: [
            if (state.restaurants.length > 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: DropdownButtonFormField<String>(
                  value: state.selectedRestaurantId,
                  decoration: InputDecoration(
                    labelText: l.selectRestaurant,
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: state.restaurants.map((r) => DropdownMenuItem<String>(
                    value: r.id,
                    child: Text(r.name),
                  )).toList(),
                  onChanged: (newId) async {
                    if (newId == null) return;
                    if (!await _confirmUnsavedChanges(context)) return;
                    if (context.mounted) {
                      context.read<MyRestaurantBloc>().add(SelectRestaurant(newId));
                    }
                  },
                ),
              ),
            TabBar(
              tabs: tabs,
              isScrollable: false,
              labelPadding: EdgeInsets.zero,
            ),
            Expanded(
              child: TabBarView(children: tabViews),
            ),
          ],
        );
          },
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
          onPermissions: isOwner
              ? (employee) => _showPermissionsDialog(context, employee)
              : null,
        ),
        if (isOwner)
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton.extended(
              onPressed: () => _showAddEmployeeDialog(context),
              icon: const Icon(Icons.person_add),
              label: Text(S.of(context).add),
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

  void _showPermissionsDialog(BuildContext context, Employee employee) {
    final userRole = _getCurrentUserRole(context);
    List<String>? grantablePermissions;
    if (userRole != UserRole.owner) {
      final myState = context.read<MyRestaurantBloc>().state;
      if (myState is MyRestaurantLoaded) {
        final authEmail = context.read<AuthBloc>().state.maybeWhen(
              authenticated: (user) => user.email,
              orElse: () => null,
            );
        final me = myState.employees.where((e) => e.email == authEmail).firstOrNull;
        grantablePermissions = me?.permissions ?? [];
      }
    }

    showDialog(
      context: context,
      builder: (_) => EmployeePermissionsDialog(
        employee: employee,
        grantablePermissions: grantablePermissions,
        onSave: (permissions) {
          context.read<MyRestaurantBloc>().add(
                UpdateEmployeePermissions(employee.id, permissions),
              );
        },
      ),
    );
  }
}
