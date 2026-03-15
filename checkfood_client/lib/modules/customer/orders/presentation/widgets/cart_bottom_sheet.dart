import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../l10n/generated/app_localizations.dart';
import '../bloc/orders_bloc.dart';
import '../bloc/orders_event.dart';
import '../bloc/orders_state.dart';

class CartBottomSheet extends StatefulWidget {
  const CartBottomSheet({super.key});

  @override
  State<CartBottomSheet> createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<OrdersBloc, OrdersState>(
      listenWhen: (prev, curr) =>
          prev.submitSuccess != curr.submitSuccess ||
          prev.submitError != curr.submitError,
      listener: (context, state) {
        if (state.submitSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).orderSent)),
          );
        }
        if (state.submitError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.submitError!)),
          );
        }
      },
      builder: (context, state) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                // Handle
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outline.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Title
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).cart,
                        style: theme.textTheme.titleLarge,
                      ),
                      if (state.cartItems.isNotEmpty)
                        TextButton(
                          onPressed: () => context
                              .read<OrdersBloc>()
                              .add(const OrdersEvent.clearCart()),
                          child: Text(S.of(context).emptyCart),
                        ),
                    ],
                  ),
                ),

                // Items list
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = state.cartItems[index];
                      return ListTile(
                        title: Text(item.itemName),
                        subtitle: Text(item.formattedUnitPrice),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline,
                                  size: 20),
                              onPressed: () => context
                                  .read<OrdersBloc>()
                                  .add(OrdersEvent.removeFromCart(
                                      menuItemId: item.menuItemId)),
                            ),
                            Text(
                              '${item.quantity}',
                              style: theme.textTheme.titleSmall,
                            ),
                            IconButton(
                              icon:
                                  const Icon(Icons.add_circle_outline, size: 20),
                              onPressed: () => context
                                  .read<OrdersBloc>()
                                  .add(OrdersEvent.updateCartQuantity(
                                    menuItemId: item.menuItemId,
                                    quantity: item.quantity + 1,
                                  )),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item.formattedTotalPrice,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Note field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _noteController,
                    decoration: InputDecoration(
                      hintText: S.of(context).orderNote,
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                    maxLines: 2,
                    maxLength: 500,
                  ),
                ),

                // Total + submit
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).total,
                            style: theme.textTheme.titleMedium,
                          ),
                          Text(
                            state.cartTotalFormatted,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: state.canSubmit
                              ? () {
                                  final note =
                                      _noteController.text.trim().isEmpty
                                          ? null
                                          : _noteController.text.trim();
                                  context.read<OrdersBloc>().add(
                                        OrdersEvent.submitOrder(note: note),
                                      );
                                }
                              : null,
                          child: state.submitting
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(S.of(context).sendOrder),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
