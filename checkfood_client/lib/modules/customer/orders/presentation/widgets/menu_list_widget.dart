import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/entities/menu_category.dart';
import '../bloc/orders_bloc.dart';
import '../bloc/orders_event.dart';
import '../bloc/orders_state.dart';
import 'menu_item_card.dart';

class MenuListWidget extends StatelessWidget {
  const MenuListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      buildWhen: (prev, curr) =>
          prev.menuCategories != curr.menuCategories ||
          prev.menuLoading != curr.menuLoading ||
          prev.cartItems != curr.cartItems,
      builder: (context, state) {
        if (state.menuLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.menuError != null) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.menuError!),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    if (state.diningContext != null) {
                      context.read<OrdersBloc>().add(
                            OrdersEvent.loadMenu(
                              restaurantId:
                                  state.diningContext!.restaurantId,
                            ),
                          );
                    }
                  },
                  child: const Text('Zkusit znovu'),
                ),
              ],
            ),
          );
        }

        if (state.menuCategories.isEmpty) {
          return const Center(child: Text('Menu je prázdné.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 100),
          itemCount: state.menuCategories.length,
          itemBuilder: (context, index) {
            final category = state.menuCategories[index];
            return _CategorySection(
              category: category,
              cartItems: state.cartItems,
            );
          },
        );
      },
    );
  }
}

class _CategorySection extends StatelessWidget {
  final MenuCategory category;
  final List<CartItem> cartItems;

  const _CategorySection({
    required this.category,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            category.name,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...category.items.map((menuItem) {
          final cartQty = _getCartQuantity(menuItem.id);
          return MenuItemCard(
            menuItem: menuItem,
            cartQuantity: cartQty,
            onAdd: () => context.read<OrdersBloc>().add(
                  OrdersEvent.addToCart(menuItem: menuItem),
                ),
            onRemove: () => context.read<OrdersBloc>().add(
                  OrdersEvent.removeFromCart(menuItemId: menuItem.id),
                ),
          );
        }),
      ],
    );
  }

  int _getCartQuantity(String menuItemId) {
    final match = cartItems.where((c) => c.menuItemId == menuItemId);
    return match.isEmpty ? 0 : match.first.quantity;
  }
}
