import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/colors.dart';
import '../bloc/orders_bloc.dart';
import '../bloc/orders_event.dart';
import '../bloc/orders_state.dart';

/// Zobrazuje seznam objednávek zadaných v průběhu aktuálního dining contextu
/// s podporou přetažení pro obnovení a ikonami stavu pro každou objednávku.
class CurrentOrdersWidget extends StatelessWidget {
  const CurrentOrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      buildWhen: (prev, curr) =>
          prev.currentOrders != curr.currentOrders ||
          prev.ordersLoading != curr.ordersLoading,
      builder: (context, state) {
        if (state.ordersLoading && state.currentOrders.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.currentOrders.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.receipt_long,
                  size: 64,
                  color: Theme.of(context).colorScheme.outline,
                ),
                const SizedBox(height: 16),
                Text(
                  'Zatím žádné objednávky',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            context
                .read<OrdersBloc>()
                .add(const OrdersEvent.loadCurrentOrders());
          },
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 100),
            itemCount: state.currentOrders.length,
            itemBuilder: (context, index) {
              final order = state.currentOrders[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: _statusIcon(order.status),
                  title: Text(
                    order.statusLabel,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  subtitle: Text(
                    '${order.itemCount} pol. · ${order.formattedTotal}',
                  ),
                  trailing: Text(
                    _formatTime(order.createdAt),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _statusIcon(String status) {
    final (IconData icon, Color color) = switch (status) {
      'PENDING' => (Icons.hourglass_top, AppColors.warning),
      'CONFIRMED' => (Icons.check_circle_outline, AppColors.info),
      'PREPARING' => (Icons.restaurant, Colors.amber),
      'READY' => (Icons.notifications_active, AppColors.success),
      'DELIVERED' => (Icons.done_all, AppColors.textMuted),
      'CANCELLED' => (Icons.cancel_outlined, AppColors.error),
      _ => (Icons.receipt, AppColors.textMuted),
    };

    return Icon(icon, color: color, size: 28);
  }

  String _formatTime(String createdAt) {
    try {
      final dt = DateTime.parse(createdAt);
      return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return '';
    }
  }
}
