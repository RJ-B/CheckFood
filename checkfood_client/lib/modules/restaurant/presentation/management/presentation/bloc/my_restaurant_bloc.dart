import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/error_helpers.dart';
import '../../domain/usecases/add_employee_usecase.dart';
import '../../domain/usecases/get_employees_usecase.dart';
import '../../domain/usecases/get_my_restaurant_usecase.dart';
import '../../domain/usecases/get_my_restaurants_usecase.dart';
import '../../domain/usecases/remove_employee_usecase.dart';
import '../../domain/usecases/update_employee_permissions_usecase.dart';
import '../../domain/usecases/update_employee_role_usecase.dart';
import '../../domain/usecases/update_restaurant_info_usecase.dart';
import 'my_restaurant_event.dart';
import 'my_restaurant_state.dart';

/// BLoC spravující dashboard restaurace majitele: načítání informací o restauraci,
/// přepínání mezi vlastněnými restauracemi, aktualizaci údajů a správu seznamu zaměstnanců.
class MyRestaurantBloc extends Bloc<MyRestaurantEvent, MyRestaurantState> {
  final GetMyRestaurantUseCase _getMyRestaurantUseCase;
  final GetMyRestaurantsUseCase _getMyRestaurantsUseCase;
  final UpdateRestaurantInfoUseCase _updateRestaurantInfoUseCase;
  final GetEmployeesUseCase _getEmployeesUseCase;
  final AddEmployeeUseCase _addEmployeeUseCase;
  final UpdateEmployeeRoleUseCase _updateEmployeeRoleUseCase;
  final RemoveEmployeeUseCase _removeEmployeeUseCase;
  final UpdateEmployeePermissionsUseCase _updateEmployeePermissionsUseCase;

  MyRestaurantBloc({
    required GetMyRestaurantUseCase getMyRestaurantUseCase,
    required GetMyRestaurantsUseCase getMyRestaurantsUseCase,
    required UpdateRestaurantInfoUseCase updateRestaurantInfoUseCase,
    required GetEmployeesUseCase getEmployeesUseCase,
    required AddEmployeeUseCase addEmployeeUseCase,
    required UpdateEmployeeRoleUseCase updateEmployeeRoleUseCase,
    required RemoveEmployeeUseCase removeEmployeeUseCase,
    required UpdateEmployeePermissionsUseCase updateEmployeePermissionsUseCase,
  })  : _getMyRestaurantUseCase = getMyRestaurantUseCase,
        _getMyRestaurantsUseCase = getMyRestaurantsUseCase,
        _updateRestaurantInfoUseCase = updateRestaurantInfoUseCase,
        _getEmployeesUseCase = getEmployeesUseCase,
        _addEmployeeUseCase = addEmployeeUseCase,
        _updateEmployeeRoleUseCase = updateEmployeeRoleUseCase,
        _removeEmployeeUseCase = removeEmployeeUseCase,
        _updateEmployeePermissionsUseCase = updateEmployeePermissionsUseCase,
        super(const MyRestaurantInitial()) {
    on<LoadMyRestaurant>(_onLoadMyRestaurant);
    on<SelectRestaurant>(_onSelectRestaurant);
    on<UpdateRestaurant>(_onUpdateRestaurant);
    on<LoadEmployees>(_onLoadEmployees);
    on<AddEmployee>(_onAddEmployee);
    on<UpdateEmployeeRole>(_onUpdateEmployeeRole);
    on<RemoveEmployee>(_onRemoveEmployee);
    on<UpdateEmployeePermissions>(_onUpdateEmployeePermissions);
  }

  Future<void> _onLoadMyRestaurant(
    LoadMyRestaurant event,
    Emitter<MyRestaurantState> emit,
  ) async {
    emit(const MyRestaurantLoading());
    try {
      final restaurants = await _getMyRestaurantsUseCase.execute();

      if (restaurants.isEmpty) {
        emit(const MyRestaurantError('Nemáte přiřazenou žádnou restauraci.'));
        return;
      }

      final selectedId = restaurants.first.id;
      final restaurant = await _getMyRestaurantUseCase.execute(restaurantId: selectedId);
      final employees = await _getEmployeesUseCase.execute(restaurantId: selectedId);

      emit(MyRestaurantLoaded(
        restaurant: restaurant,
        restaurants: restaurants,
        selectedRestaurantId: selectedId,
        employees: employees,
      ));
    } catch (e) {
      emit(MyRestaurantError(userFriendlyError(e)));
    }
  }

  Future<void> _onSelectRestaurant(
    SelectRestaurant event,
    Emitter<MyRestaurantState> emit,
  ) async {
    final currentState = state;
    if (currentState is! MyRestaurantLoaded) return;

    emit(currentState.copyWith(isUpdating: true));
    try {
      final restaurant = await _getMyRestaurantUseCase.execute(restaurantId: event.restaurantId);
      final employees = await _getEmployeesUseCase.execute(restaurantId: event.restaurantId);

      emit(MyRestaurantLoaded(
        restaurant: restaurant,
        restaurants: currentState.restaurants,
        selectedRestaurantId: event.restaurantId,
        employees: employees,
        isUpdating: false,
      ));
    } catch (e) {
      emit(currentState.copyWith(isUpdating: false));
      emit(MyRestaurantError(userFriendlyError(e)));
    }
  }

  Future<void> _onUpdateRestaurant(
    UpdateRestaurant event,
    Emitter<MyRestaurantState> emit,
  ) async {
    final currentState = state;
    if (currentState is! MyRestaurantLoaded) return;

    emit(currentState.copyWith(isUpdating: true));
    try {
      final selectedId = currentState.selectedRestaurantId;
      final updated = await _updateRestaurantInfoUseCase.execute(event.request, restaurantId: selectedId);
      emit(currentState.copyWith(restaurant: updated, isUpdating: false));
    } catch (e) {
      emit(currentState.copyWith(isUpdating: false));
      emit(MyRestaurantError(userFriendlyError(e)));
    }
  }

  Future<void> _onLoadEmployees(
    LoadEmployees event,
    Emitter<MyRestaurantState> emit,
  ) async {
    final currentState = state;
    if (currentState is! MyRestaurantLoaded) return;

    try {
      final employees = await _getEmployeesUseCase.execute(restaurantId: currentState.selectedRestaurantId);
      emit(currentState.copyWith(employees: employees));
    } catch (e) {
      emit(MyRestaurantError(userFriendlyError(e)));
    }
  }

  Future<void> _onAddEmployee(
    AddEmployee event,
    Emitter<MyRestaurantState> emit,
  ) async {
    final currentState = state;
    if (currentState is! MyRestaurantLoaded) return;

    emit(currentState.copyWith(isUpdating: true));
    try {
      await _addEmployeeUseCase.execute(event.request, restaurantId: currentState.selectedRestaurantId);
      final employees = await _getEmployeesUseCase.execute(restaurantId: currentState.selectedRestaurantId);
      emit(currentState.copyWith(employees: employees, isUpdating: false));
    } catch (e) {
      emit(currentState.copyWith(isUpdating: false));
      emit(MyRestaurantError(userFriendlyError(e)));
    }
  }

  Future<void> _onUpdateEmployeeRole(
    UpdateEmployeeRole event,
    Emitter<MyRestaurantState> emit,
  ) async {
    final currentState = state;
    if (currentState is! MyRestaurantLoaded) return;

    emit(currentState.copyWith(isUpdating: true));
    try {
      await _updateEmployeeRoleUseCase.execute(event.employeeId, event.request, restaurantId: currentState.selectedRestaurantId);
      final employees = await _getEmployeesUseCase.execute(restaurantId: currentState.selectedRestaurantId);
      emit(currentState.copyWith(employees: employees, isUpdating: false));
    } catch (e) {
      emit(currentState.copyWith(isUpdating: false));
      emit(MyRestaurantError(userFriendlyError(e)));
    }
  }

  Future<void> _onRemoveEmployee(
    RemoveEmployee event,
    Emitter<MyRestaurantState> emit,
  ) async {
    final currentState = state;
    if (currentState is! MyRestaurantLoaded) return;

    emit(currentState.copyWith(isUpdating: true));
    try {
      await _removeEmployeeUseCase.execute(event.employeeId, restaurantId: currentState.selectedRestaurantId);
      final employees = await _getEmployeesUseCase.execute(restaurantId: currentState.selectedRestaurantId);
      emit(currentState.copyWith(employees: employees, isUpdating: false));
    } catch (e) {
      emit(currentState.copyWith(isUpdating: false));
      emit(MyRestaurantError(userFriendlyError(e)));
    }
  }

  Future<void> _onUpdateEmployeePermissions(
    UpdateEmployeePermissions event,
    Emitter<MyRestaurantState> emit,
  ) async {
    final currentState = state;
    if (currentState is! MyRestaurantLoaded) return;

    emit(currentState.copyWith(isUpdating: true));
    try {
      await _updateEmployeePermissionsUseCase.execute(
        event.employeeId,
        event.permissions,
        restaurantId: currentState.selectedRestaurantId,
      );
      final employees = await _getEmployeesUseCase.execute(
        restaurantId: currentState.selectedRestaurantId,
      );
      emit(currentState.copyWith(employees: employees, isUpdating: false));
    } catch (e) {
      emit(currentState.copyWith(isUpdating: false));
      emit(MyRestaurantError(userFriendlyError(e)));
    }
  }

}
