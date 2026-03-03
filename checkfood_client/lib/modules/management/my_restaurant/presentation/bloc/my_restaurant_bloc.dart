import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_employee_usecase.dart';
import '../../domain/usecases/get_employees_usecase.dart';
import '../../domain/usecases/get_my_restaurant_usecase.dart';
import '../../domain/usecases/remove_employee_usecase.dart';
import '../../domain/usecases/update_employee_role_usecase.dart';
import '../../domain/usecases/update_restaurant_info_usecase.dart';
import 'my_restaurant_event.dart';
import 'my_restaurant_state.dart';

class MyRestaurantBloc extends Bloc<MyRestaurantEvent, MyRestaurantState> {
  final GetMyRestaurantUseCase _getMyRestaurantUseCase;
  final UpdateRestaurantInfoUseCase _updateRestaurantInfoUseCase;
  final GetEmployeesUseCase _getEmployeesUseCase;
  final AddEmployeeUseCase _addEmployeeUseCase;
  final UpdateEmployeeRoleUseCase _updateEmployeeRoleUseCase;
  final RemoveEmployeeUseCase _removeEmployeeUseCase;

  MyRestaurantBloc({
    required GetMyRestaurantUseCase getMyRestaurantUseCase,
    required UpdateRestaurantInfoUseCase updateRestaurantInfoUseCase,
    required GetEmployeesUseCase getEmployeesUseCase,
    required AddEmployeeUseCase addEmployeeUseCase,
    required UpdateEmployeeRoleUseCase updateEmployeeRoleUseCase,
    required RemoveEmployeeUseCase removeEmployeeUseCase,
  })  : _getMyRestaurantUseCase = getMyRestaurantUseCase,
        _updateRestaurantInfoUseCase = updateRestaurantInfoUseCase,
        _getEmployeesUseCase = getEmployeesUseCase,
        _addEmployeeUseCase = addEmployeeUseCase,
        _updateEmployeeRoleUseCase = updateEmployeeRoleUseCase,
        _removeEmployeeUseCase = removeEmployeeUseCase,
        super(const MyRestaurantInitial()) {
    on<LoadMyRestaurant>(_onLoadMyRestaurant);
    on<UpdateRestaurant>(_onUpdateRestaurant);
    on<LoadEmployees>(_onLoadEmployees);
    on<AddEmployee>(_onAddEmployee);
    on<UpdateEmployeeRole>(_onUpdateEmployeeRole);
    on<RemoveEmployee>(_onRemoveEmployee);
  }

  Future<void> _onLoadMyRestaurant(
    LoadMyRestaurant event,
    Emitter<MyRestaurantState> emit,
  ) async {
    emit(const MyRestaurantLoading());
    try {
      final restaurant = await _getMyRestaurantUseCase.execute();
      final employees = await _getEmployeesUseCase.execute();
      emit(MyRestaurantLoaded(restaurant: restaurant, employees: employees));
    } catch (e) {
      emit(MyRestaurantError(_extractMessage(e)));
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
      final updated = await _updateRestaurantInfoUseCase.execute(event.request);
      emit(currentState.copyWith(restaurant: updated, isUpdating: false));
    } catch (e) {
      emit(currentState.copyWith(isUpdating: false));
      emit(MyRestaurantError(_extractMessage(e)));
    }
  }

  Future<void> _onLoadEmployees(
    LoadEmployees event,
    Emitter<MyRestaurantState> emit,
  ) async {
    final currentState = state;
    if (currentState is! MyRestaurantLoaded) return;

    try {
      final employees = await _getEmployeesUseCase.execute();
      emit(currentState.copyWith(employees: employees));
    } catch (e) {
      emit(MyRestaurantError(_extractMessage(e)));
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
      await _addEmployeeUseCase.execute(event.request);
      final employees = await _getEmployeesUseCase.execute();
      emit(currentState.copyWith(employees: employees, isUpdating: false));
    } catch (e) {
      emit(currentState.copyWith(isUpdating: false));
      emit(MyRestaurantError(_extractMessage(e)));
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
      await _updateEmployeeRoleUseCase.execute(event.employeeId, event.request);
      final employees = await _getEmployeesUseCase.execute();
      emit(currentState.copyWith(employees: employees, isUpdating: false));
    } catch (e) {
      emit(currentState.copyWith(isUpdating: false));
      emit(MyRestaurantError(_extractMessage(e)));
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
      await _removeEmployeeUseCase.execute(event.employeeId);
      final employees = await _getEmployeesUseCase.execute();
      emit(currentState.copyWith(employees: employees, isUpdating: false));
    } catch (e) {
      emit(currentState.copyWith(isUpdating: false));
      emit(MyRestaurantError(_extractMessage(e)));
    }
  }

  String _extractMessage(Object error) {
    if (error is Exception) {
      return error.toString().replaceFirst('Exception: ', '');
    }
    return 'Nastala neočekávaná chyba.';
  }
}
