import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/orders_bloc.dart';
import '../bloc/orders_event.dart';
import '../bloc/orders_state.dart';
import '../widgets/cart_summary_bar.dart';
import '../widgets/current_orders_widget.dart';
import '../widgets/menu_list_widget.dart';
import '../widgets/no_context_widget.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersBloc>().add(const OrdersEvent.loadContext());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      buildWhen: (prev, curr) =>
          prev.contextLoading != curr.contextLoading ||
          prev.noActiveContext != curr.noActiveContext ||
          prev.hasContext != curr.hasContext ||
          prev.contextError != curr.contextError,
      builder: (context, state) {
        // Loading context
        if (state.contextLoading) {
          return Scaffold(
            appBar: AppBar(title: const Text('Objednávky')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        // No active context
        if (state.noActiveContext) {
          return Scaffold(
            appBar: AppBar(title: const Text('Objednávky')),
            body: const NoContextWidget(),
          );
        }

        // Context error
        if (state.contextError != null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Objednávky')),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.contextError!),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => context
                        .read<OrdersBloc>()
                        .add(const OrdersEvent.loadContext()),
                    child: const Text('Zkusit znovu'),
                  ),
                ],
              ),
            ),
          );
        }

        // Has context — show menu + orders tabs
        return _OrdersTabView(
          restaurantName: state.diningContext?.restaurantName ?? '',
          tableLabel: state.diningContext?.tableLabel ?? '',
        );
      },
    );
  }
}

class _OrdersTabView extends StatelessWidget {
  final String restaurantName;
  final String tableLabel;

  const _OrdersTabView({
    required this.restaurantName,
    required this.tableLabel,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurantName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                tableLabel,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.restaurant_menu), text: 'Menu'),
              Tab(icon: Icon(Icons.receipt_long), text: 'Moje objednávky'),
            ],
          ),
        ),
        body: const Stack(
          children: [
            TabBarView(
              children: [
                MenuListWidget(),
                CurrentOrdersWidget(),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CartSummaryBar(),
            ),
          ],
        ),
      ),
    );
  }
}
