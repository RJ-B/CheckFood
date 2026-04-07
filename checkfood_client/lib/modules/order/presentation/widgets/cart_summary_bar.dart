import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/orders_bloc.dart';
import '../bloc/orders_state.dart';
import 'cart_bottom_sheet.dart';
import '../../../../../../l10n/generated/app_localizations.dart';

/// Přichycený pruh ve spodní části obrazovky zobrazující počet položek a celkovou cenu košíku;
/// po klepnutí otevře [CartBottomSheet].
class CartSummaryBar extends StatelessWidget {
  const CartSummaryBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      buildWhen: (prev, curr) =>
          prev.cartItems != curr.cartItems ||
          prev.submitting != curr.submitting,
      builder: (context, state) {
        final l = S.of(context);
        if (state.cartItems.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8 + MediaQuery.of(context).viewPadding.bottom),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: FilledButton(
              onPressed: state.submitting
                  ? null
                  : () => _showCartSheet(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.shopping_bag_outlined, size: 20),
                        const SizedBox(width: 8),
                        Text(l.itemsShort(state.cartItemCount)),
                      ],
                    ),
                    Text(
                      state.cartTotalFormatted,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(l.order),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showCartSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => BlocProvider.value(
        value: context.read<OrdersBloc>(),
        child: const CartBottomSheet(),
      ),
    );
  }
}
