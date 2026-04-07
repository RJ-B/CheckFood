import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../../core/theme/colors.dart';
import '../../domain/entities/session_order_item.dart';
import '../bloc/orders_bloc.dart';
import '../bloc/orders_event.dart';
import '../bloc/orders_state.dart';
import '../pages/qr_scanner_page.dart';

/// Zobrazuje sdílený účet dining session — hosté mohou vybrat a zaplatit
/// své položky nebo pozvat ostatní pomocí QR kódu.
class SessionBillWidget extends StatelessWidget {
  const SessionBillWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        if (state.sessionLoading && state.sessionItems.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.sessionError != null && state.sessionItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 48, color: AppColors.error),
                const SizedBox(height: 12),
                Text(state.sessionError!),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    context.read<OrdersBloc>().add(const OrdersEvent.loadSession());
                    context.read<OrdersBloc>().add(const OrdersEvent.loadSessionOrders());
                  },
                  child: const Text('Zkusit znovu'),
                ),
              ],
            ),
          );
        }

        if (!state.hasSession && state.sessionItems.isEmpty) {
          return _NoSessionView();
        }

        return Column(
          children: [
            _SessionHeader(state: state),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<OrdersBloc>().add(const OrdersEvent.loadSession());
                  context.read<OrdersBloc>().add(const OrdersEvent.loadSessionOrders());
                },
                child: state.sessionItems.isEmpty
                    ? const _EmptyItemsView()
                    : _ItemsList(items: state.sessionItems, state: state),
              ),
            ),
            _BillFooter(state: state),
          ],
        );
      },
    );
  }
}

/// Výzva zobrazená, pokud uživatel nemá aktivní skupinové sezení — obsahuje tlačítko pro naskenování QR kódu stolu.
class _NoSessionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.table_restaurant,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'Žádné aktivní sezení u stolu',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Naskenujte QR kód stolu pro připojení ke skupinovému účtu.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => _openQrScanner(context),
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Naskenovat QR kód'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Kompaktní záhlaví zobrazující kontext restaurace a stolu, počet členů a akční tlačítka session.
class _SessionHeader extends StatelessWidget {
  final OrdersState state;
  const _SessionHeader({required this.state});

  @override
  Widget build(BuildContext context) {
    final memberCount = state.session?.members.length ?? 0;
    final inviteCode = state.session?.inviteCode ?? state.sessionInviteCode;

    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.diningContext?.restaurantName ?? '',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  state.diningContext?.tableLabel ?? '',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                if (memberCount > 0)
                  Text(
                    '$memberCount ${_personLabel(memberCount)} u stolu',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.primary,
                        ),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            tooltip: 'Připojit dalšího hosta',
            onPressed: () => _openQrScanner(context),
          ),
          if (inviteCode != null)
            IconButton(
              icon: const Icon(Icons.share),
              tooltip: 'Sdílet QR kód stolu',
              onPressed: () => _showQrDialog(context, inviteCode),
            )
          else
            IconButton(
              icon: const Icon(Icons.qr_code),
              tooltip: 'Zobrazit QR kód stolu',
              onPressed: () {
                context.read<OrdersBloc>().add(const OrdersEvent.showSessionQr());
              },
            ),
        ],
      ),
    );
  }

  String _personLabel(int count) {
    if (count == 1) return 'host';
    if (count <= 4) return 'hosté';
    return 'hostů';
  }
}

/// Zástupný obsah zobrazený v oblasti s možností obnovení, pokud session zatím neobsahuje žádné objednané položky.
class _EmptyItemsView extends StatelessWidget {
  const _EmptyItemsView();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 80),
        Center(
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
                'Zatím žádné položky v sezení',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Scrollovatelný seznam všech řádků [SessionOrderItem] v rámci aktivní session.
class _ItemsList extends StatelessWidget {
  final List<SessionOrderItem> items;
  final OrdersState state;

  const _ItemsList({required this.items, required this.state});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 4, bottom: 8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _ItemRow(item: item, state: state);
      },
    );
  }
}

/// Vybratelný řádek reprezentující jednu objednanou položku v session, zobrazuje stav platby.
class _ItemRow extends StatelessWidget {
  final SessionOrderItem item;
  final OrdersState state;

  const _ItemRow({required this.item, required this.state});

  @override
  Widget build(BuildContext context) {
    final isPaid = item.isPaid;
    final isPaying = item.isPaying;
    final isSelected = state.selectedItemIds.contains(item.id);
    final canSelect = !isPaid && !isPaying;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      decoration: BoxDecoration(
        color: isPaid
            ? AppColors.successLight
            : isPaying
                ? AppColors.warningLight
                : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected
              ? AppColors.primary
              : Theme.of(context).colorScheme.outlineVariant,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: canSelect
            ? () => context
                .read<OrdersBloc>()
                .add(OrdersEvent.toggleItemSelection(itemId: item.id))
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: isSelected,
                  onChanged: canSelect
                      ? (_) => context
                          .read<OrdersBloc>()
                          .add(OrdersEvent.toggleItemSelection(itemId: item.id))
                      : null,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.quantity > 1
                          ? '${item.quantity}× ${item.name}'
                          : item.name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            decoration: isPaid
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                    ),
                    if (item.orderedByName != null)
                      Text(
                        item.orderedByName!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    item.formattedPrice,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 4),
                  _StatusBadge(item: item),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Barevný odznak indikující, zda je položka nezaplacená, zpracovává se nebo zaplacená.
class _StatusBadge extends StatelessWidget {
  final SessionOrderItem item;
  const _StatusBadge({required this.item});

  @override
  Widget build(BuildContext context) {
    if (item.isPaid) {
      final paidBy = item.paidByName;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.success,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          paidBy != null ? 'Zaplaceno ($paidBy)' : 'Zaplaceno',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    if (item.isPaying) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.warning,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Zpracovává se',
          style: TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Nezaplaceno',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontSize: 11,
        ),
      ),
    );
  }
}

/// Přichycený footer zobrazující celkové částky session a akci pro platbu vybraných položek.
class _BillFooter extends StatelessWidget {
  final OrdersState state;
  const _BillFooter({required this.state});

  @override
  Widget build(BuildContext context) {
    final hasSelection = state.selectedItemIds.isNotEmpty;
    final isPaying = state.paymentInitiating;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _TotalRow(
            label: 'Celkem:',
            value: state.sessionTotalFormatted,
            bold: false,
          ),
          if (state.sessionPaidMinor > 0) ...[
            _TotalRow(
              label: 'Zaplaceno:',
              value: state.sessionPaidFormatted,
              color: AppColors.success,
              bold: false,
            ),
            _TotalRow(
              label: 'Zbývá:',
              value: state.sessionRemainingFormatted,
              bold: true,
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: state.sessionItems.any((i) => i.isUnpaid)
                      ? () => context
                          .read<OrdersBloc>()
                          .add(const OrdersEvent.selectAllMyItems())
                      : null,
                  child: const Text('Vybrat moje položky'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: FilledButton(
                  onPressed: hasSelection && !isPaying
                      ? () => context
                          .read<OrdersBloc>()
                          .add(const OrdersEvent.paySelectedItems())
                      : null,
                  child: isPaying
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          hasSelection
                              ? 'Zaplatit vybrané (${state.selectedTotalFormatted})'
                              : 'Zaplatit vybrané',
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Řádek páru popisek–hodnota ve footeru účtu pro zobrazení peněžních součtů.
class _TotalRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  final Color? color;

  const _TotalRow({
    required this.label,
    required this.value,
    required this.bold,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final style = bold
        ? Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: color)
        : Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: color ?? Theme.of(context).colorScheme.onSurface);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }
}

void _openQrScanner(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: context.read<OrdersBloc>(),
        child: const QrScannerPage(),
      ),
    ),
  );
}

void _showQrDialog(BuildContext context, String inviteCode) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('QR kód stolu'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          QrImageView(
            data: inviteCode,
            size: 220,
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 12),
          Text(
            'Sdílejte tento kód s ostatními hosty u stolu.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
          SelectableText(
            inviteCode,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Zavřít'),
        ),
      ],
    ),
  );
}
