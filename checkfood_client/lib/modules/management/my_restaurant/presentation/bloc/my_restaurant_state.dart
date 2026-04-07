import '../../domain/entities/employee.dart';
import '../../domain/entities/my_restaurant.dart';

/// Base class for [MyRestaurantBloc] states.
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
  final List<MyRestaurant> restaurants;
  final String? selectedRestaurantId;
  final List<Employee> employees;
  final bool isUpdating;

  const MyRestaurantLoaded({
    required this.restaurant,
    this.restaurants = const [],
    this.selectedRestaurantId,
    this.employees = const [],
    this.isUpdating = false,
  });

  MyRestaurantLoaded copyWith({
    MyRestaurant? restaurant,
    List<MyRestaurant>? restaurants,
    String? selectedRestaurantId,
    List<Employee>? employees,
    bool? isUpdating,
  }) {
    return MyRestaurantLoaded(
      restaurant: restaurant ?? this.restaurant,
      restaurants: restaurants ?? this.restaurants,
      selectedRestaurantId: selectedRestaurantId ?? this.selectedRestaurantId,
      employees: employees ?? this.employees,
      isUpdating: isUpdating ?? this.isUpdating,
    );
  }
}

class MyRestaurantError extends MyRestaurantState {
  final String message;
  const MyRestaurantError(this.message);
}
