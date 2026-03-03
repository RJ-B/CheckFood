import '../../domain/entities/employee.dart';
import '../../domain/entities/my_restaurant.dart';

abstract class MyRestaurantState {
  const MyRestaurantState();
}

class MyRestaurantInitial extends MyRestaurantState {
  const MyRestaurantInitial();
}

class MyRestaurantLoading extends MyRestaurantState {
  const MyRestaurantLoading();
}

class MyRestaurantLoaded extends MyRestaurantState {
  final MyRestaurant restaurant;
  final List<Employee> employees;
  final bool isUpdating;

  const MyRestaurantLoaded({
    required this.restaurant,
    this.employees = const [],
    this.isUpdating = false,
  });

  MyRestaurantLoaded copyWith({
    MyRestaurant? restaurant,
    List<Employee>? employees,
    bool? isUpdating,
  }) {
    return MyRestaurantLoaded(
      restaurant: restaurant ?? this.restaurant,
      employees: employees ?? this.employees,
      isUpdating: isUpdating ?? this.isUpdating,
    );
  }
}

class MyRestaurantError extends MyRestaurantState {
  final String message;
  const MyRestaurantError(this.message);
}
