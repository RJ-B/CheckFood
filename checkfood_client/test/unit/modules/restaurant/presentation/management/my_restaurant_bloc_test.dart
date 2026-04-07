import 'package:flutter_test/flutter_test.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/presentation/bloc/my_restaurant_bloc.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/presentation/bloc/my_restaurant_event.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/presentation/bloc/my_restaurant_state.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/domain/entities/employee.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/domain/entities/my_restaurant.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/domain/usecases/get_my_restaurant_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/domain/usecases/get_my_restaurants_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/domain/usecases/update_restaurant_info_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/domain/usecases/get_employees_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/domain/usecases/add_employee_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/domain/usecases/update_employee_role_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/domain/usecases/remove_employee_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/domain/usecases/update_employee_permissions_usecase.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/domain/repositories/my_restaurant_repository.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/data/models/request/add_employee_request_model.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/data/models/request/update_employee_role_request_model.dart';
import 'package:checkfood_client/modules/restaurant/presentation/management/data/models/request/update_restaurant_request_model.dart';
import 'package:checkfood_client/modules/restaurant/domain/entities/address.dart';

// --- Fake Repository ---

class FakeMyRestaurantRepository implements MyRestaurantRepository {
  bool addEmployeeCalled = false;
  String? lastAddedEmail;

  final _restaurant = MyRestaurant(
    id: 'r1',
    name: 'Test Restaurant',
    description: 'A test restaurant',
    phone: '+420123456789',
    contactEmail: 'info@test.com',
    address: const Address(street: 'Test St', city: 'Prague', country: 'CZ'),
    openingHours: [],
    status: 'ACTIVE',
    isActive: true,
  );

  final _employees = [
    const Employee(id: 1, userId: 10, name: 'Owner', email: 'owner@test.com', role: 'OWNER'),
    const Employee(id: 2, userId: 20, name: 'Manager', email: 'mgr@test.com', role: 'MANAGER'),
  ];

  @override
  Future<List<MyRestaurant>> getMyRestaurants() async => [_restaurant];

  @override
  Future<MyRestaurant> getMyRestaurant({String? restaurantId}) async => _restaurant;

  @override
  Future<MyRestaurant> updateMyRestaurant(UpdateRestaurantRequestModel request, {String? restaurantId}) async =>
      MyRestaurant(
        id: 'r1',
        name: request.name,
        description: request.description,
        address: const Address(street: 'Test St', city: 'Prague', country: 'CZ'),
        openingHours: [],
        status: 'ACTIVE',
        isActive: true,
      );

  @override
  Future<List<Employee>> getEmployees({String? restaurantId}) async => _employees;

  @override
  Future<Employee> addEmployee(AddEmployeeRequestModel request, {String? restaurantId}) async {
    addEmployeeCalled = true;
    lastAddedEmail = request.email;
    return Employee(id: 3, userId: 30, name: 'New', email: request.email, role: request.role);
  }

  @override
  Future<Employee> updateEmployeeRole(int employeeId, UpdateEmployeeRoleRequestModel request, {String? restaurantId}) async =>
      Employee(id: employeeId, userId: 20, name: 'Manager', email: 'mgr@test.com', role: request.role);

  @override
  Future<void> removeEmployee(int employeeId, {String? restaurantId}) async {}

  @override
  Future<List<String>> getEmployeePermissions(int employeeId, {String? restaurantId}) async => [];

  @override
  Future<List<String>> updateEmployeePermissions(int employeeId, List<String> permissions, {String? restaurantId}) async => permissions;
}

void main() {
  late FakeMyRestaurantRepository fakeRepo;
  late MyRestaurantBloc bloc;

  setUp(() {
    fakeRepo = FakeMyRestaurantRepository();
    bloc = MyRestaurantBloc(
      getMyRestaurantUseCase: GetMyRestaurantUseCase(fakeRepo),
      getMyRestaurantsUseCase: GetMyRestaurantsUseCase(fakeRepo),
      updateRestaurantInfoUseCase: UpdateRestaurantInfoUseCase(fakeRepo),
      getEmployeesUseCase: GetEmployeesUseCase(fakeRepo),
      addEmployeeUseCase: AddEmployeeUseCase(fakeRepo),
      updateEmployeeRoleUseCase: UpdateEmployeeRoleUseCase(fakeRepo),
      removeEmployeeUseCase: RemoveEmployeeUseCase(fakeRepo),
      updateEmployeePermissionsUseCase: UpdateEmployeePermissionsUseCase(fakeRepo),
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('MyRestaurantBloc', () {
    test('initial state is MyRestaurantInitial', () {
      expect(bloc.state, isA<MyRestaurantInitial>());
    });

    test('LoadMyRestaurant emits Loading then Loaded', () async {
      bloc.add(const LoadMyRestaurant());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<MyRestaurantLoading>(),
          isA<MyRestaurantLoaded>(),
        ]),
      );

      final state = bloc.state as MyRestaurantLoaded;
      expect(state.restaurant.name, 'Test Restaurant');
      expect(state.employees.length, 2);
      expect(state.restaurants.length, 1);
      expect(state.selectedRestaurantId, 'r1');
    });

    test('AddEmployee calls correct endpoint and reloads employees', () async {
      // First load
      bloc.add(const LoadMyRestaurant());
      await bloc.stream.firstWhere((s) => s is MyRestaurantLoaded);

      // Then add employee
      bloc.add(const AddEmployee(
        AddEmployeeRequestModel(email: 'new@employee.com', role: 'STAFF'),
      ));

      await bloc.stream.firstWhere(
        (s) => s is MyRestaurantLoaded && !(s).isUpdating,
      );

      expect(fakeRepo.addEmployeeCalled, true);
      expect(fakeRepo.lastAddedEmail, 'new@employee.com');
    });

    test('UpdateRestaurant updates restaurant info', () async {
      bloc.add(const LoadMyRestaurant());
      await bloc.stream.firstWhere((s) => s is MyRestaurantLoaded);

      bloc.add(const UpdateRestaurant(
        UpdateRestaurantRequestModel(name: 'Updated Name'),
      ));

      await bloc.stream.firstWhere(
        (s) => s is MyRestaurantLoaded && !(s).isUpdating,
      );

      final state = bloc.state as MyRestaurantLoaded;
      expect(state.restaurant.name, 'Updated Name');
    });

    test('SelectRestaurant switches selected restaurant', () async {
      bloc.add(const LoadMyRestaurant());
      await bloc.stream.firstWhere((s) => s is MyRestaurantLoaded);

      bloc.add(const SelectRestaurant('r1'));

      await bloc.stream.firstWhere(
        (s) => s is MyRestaurantLoaded && !(s).isUpdating,
      );

      final state = bloc.state as MyRestaurantLoaded;
      expect(state.selectedRestaurantId, 'r1');
    });
  });
}
