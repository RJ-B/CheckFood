import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../l10n/generated/app_localizations.dart';
import '../bloc/orders_bloc.dart';
import '../bloc/orders_event.dart';
import '../bloc/orders_state.dart';
import '../widgets/cart_summary_bar.dart';
import '../widgets/current_orders_widget.dart';
import '../widgets/menu_list_widget.dart';
import '../widgets/no_context_widget.dart';
import '../widgets/session_bill_widget.dart';

/// Hlavní page záložky objednávek.
///
/// Při inicializaci načte dining context a přesměruje na [_OrdersTabView], pokud
/// je kontext dostupný, nebo na [NoContextWidget], pokud žádný aktivní kontext není.
class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<OrdersBloc>().add(const OrdersEvent.loadContext());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<OrdersBloc>().add(const OrdersEvent.loadContext());
    }
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
        final l = S.of(context);
        if (state.contextLoading) {
          return Scaffold(
            appBar: AppBar(title: Text(l.ordersTitle)),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state.noActiveContext) {
          return Scaffold(
            appBar: AppBar(title: Text(l.ordersTitle)),
            body: NoContextWidget(
              onRefresh: () => context.read<OrdersBloc>().add(const OrdersEvent.loadContext()),
            ),
          );
        }

        if (state.contextError != null) {
          return Scaffold(
            appBar: AppBar(title: Text(l.ordersTitle)),
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
                    child: Text(l.retry),
                  ),
                ],
              ),
            ),
          );
        }

        return _OrdersTabView(
          restaurantName: state.diningContext?.restaurantName ?? '',
          tableLabel: state.diningContext?.tableLabel ?? '',
        );
      },
    );
  }
}

/// Scaffold se třemi záložkami zobrazující menu, aktivní objednávky a sdílený účet relace.
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
      length: 3,
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
          bottom: TabBar(
            tabs: [
              Tab(icon: const Icon(Icons.restaurant_menu), text: S.of(context).menu),
              Tab(icon: const Icon(Icons.receipt_long), text: S.of(context).myOrders),
              const Tab(icon: Icon(Icons.receipt), text: 'Účet'),
            ],
          ),
        ),
        body: const Stack(
          children: [
            TabBarView(
              children: [
                MenuListWidget(),
                CurrentOrdersWidget(),
                SessionBillWidget(),
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
