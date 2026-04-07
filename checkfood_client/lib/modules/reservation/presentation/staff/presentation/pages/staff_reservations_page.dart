import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../l10n/generated/app_localizations.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../restaurant/presentation/management/presentation/bloc/my_restaurant_bloc.dart';
import '../../../../../restaurant/presentation/management/presentation/bloc/my_restaurant_state.dart';
import '../../domain/entities/staff_table.dart';
import '../bloc/staff_reservations_bloc.dart';
import '../bloc/staff_reservations_event.dart';
import '../bloc/staff_reservations_state.dart';
import '../widgets/timeline/reservation_timeline_view.dart';
import '../widgets/timeline/reservation_detail_sheet.dart';
import '../widgets/timeline/staff_edit_reservation_sheet.dart';


/// Stránka rezervací pro personál zobrazující buď timeline nebo seznam
/// rezervací pro vybraný den, s akcemi pro potvrzení, zamítnutí,
/// check-in, dokončení, úpravu a prodloužení jednotlivých rezervací.
class StaffReservationsPage extends StatefulWidget {
  const StaffReservationsPage({super.key});

  @override
  State<StaffReservationsPage> createState() => _StaffReservationsPageState();
}

class _StaffReservationsPageState extends State<StaffReservationsPage> {
  bool _showListView = false;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<StaffReservationsBloc>();
    String? restaurantId;
    final myState = context.read<MyRestaurantBloc>().state;
    if (myState is MyRestaurantLoaded) {
      restaurantId = myState.selectedRestaurantId;
    }
    bloc.add(LoadStaffReservations(bloc.state.selectedDate, restaurantId: restaurantId));
    bloc.startPolling();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StaffReservationsBloc, StaffReservationsState>(
      listenWhen: (prev, curr) {
        return curr.actionError != null && curr.actionError != prev.actionError;
      },
      listener: (context, state) {
        if (state.actionError != null) {
          final errorMsg = state.actionError!;
          final isConflict = errorMsg.contains('obsazen') ||
                             errorMsg.contains('SLOT_CONFLICT') ||
                             errorMsg.contains('409');
          if (isConflict) {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Nelze provést změnu'),
                content: const Text(
                  'Zvolený čas zasahuje do jiné rezervace. Zvolte prosím jiný čas nebo stůl.',
                ),
                actions: [
                  FilledButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Rozumím'),
                  ),
                ],
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMsg),
                backgroundColor: AppColors.error,
              ),
            );
          }
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            _buildDateNavigator(context, state),
            Expanded(
              child: _showListView
                  ? _buildListView(context, state)
                  : _buildTimelineView(context, state),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDateNavigator(
      BuildContext context, StaffReservationsState state) {
    final date = DateTime.tryParse(state.selectedDate) ?? DateTime.now();
    final formatter = DateFormat('EEEE, d. MMMM', 'cs');
    final bloc = context.read<StaffReservationsBloc>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              final prev = date.subtract(const Duration(days: 1));
              bloc.add(ChangeDate(DateFormat('yyyy-MM-dd').format(prev)));
            },
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime.now().subtract(const Duration(days: 30)),
                  lastDate: DateTime.now().add(const Duration(days: 90)),
                  locale: const Locale('cs', 'CZ'),
                );
                if (picked != null) {
                  bloc.add(ChangeDate(DateFormat('yyyy-MM-dd').format(picked)));
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    formatter.format(date),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.calendar_month, size: 18, color: Colors.grey.shade600),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              final next = date.add(const Duration(days: 1));
              bloc.add(ChangeDate(DateFormat('yyyy-MM-dd').format(next)));
            },
          ),
          const SizedBox(width: 4),
          IconButton(
            icon: Icon(_showListView ? Icons.view_timeline : Icons.list),
            tooltip: _showListView ? 'Timeline' : 'Seznam',
            onPressed: () => setState(() => _showListView = !_showListView),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(BuildContext context, StaffReservationsState state) {
    if (state.isLoading && state.reservations.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final reservations = state.reservations
        .where((r) => !['CANCELLED', 'REJECTED'].contains(r.status))
        .toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    if (reservations.isEmpty) {
      return Center(
        child: Text(
          'Žádné rezervace na tento den.',
          style: TextStyle(color: AppColors.textMuted, fontSize: 14),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<StaffReservationsBloc>().add(PollRefresh());
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: reservations.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final r = reservations[index];
          final timeRange = r.endTime != null
              ? '${r.startTime.substring(0, 5)} – ${r.endTime!.substring(0, 5)}'
              : 'od ${r.startTime.substring(0, 5)}';

          Color statusColor;
          String statusText;
          switch (r.status) {
            case 'CONFIRMED':
              statusColor = AppColors.success;
              statusText = 'Potvrzeno';
              break;
            case 'CHECKED_IN':
              statusColor = AppColors.info;
              statusText = 'Přítomen';
              break;
            case 'COMPLETED':
              statusColor = AppColors.textMuted;
              statusText = 'Dokončeno';
              break;
            case 'PENDING_CONFIRMATION':
            case 'RESERVED':
              statusColor = Colors.orange;
              statusText = 'Čeká';
              break;
            default:
              statusColor = AppColors.textMuted;
              statusText = r.status;
          }

          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: AppColors.border.withValues(alpha: 0.5)),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => _showReservationDetail(context, r, state),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          timeRange,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          r.tableLabel,
                          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            r.userName ?? 'Host',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '${r.partySize} ${r.partySize == 1 ? 'osoba' : r.partySize < 5 ? 'osoby' : 'osob'}',
                            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        statusText,
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: statusColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimelineView(
      BuildContext context, StaffReservationsState state) {
    String openAt = '08:00';
    String closeAt = '22:00';

    final myRestaurantState = context.read<MyRestaurantBloc>().state;
    if (myRestaurantState is MyRestaurantLoaded) {
      final date = DateTime.tryParse(state.selectedDate) ?? DateTime.now();
      final dayOfWeek = date.weekday;
      final hours = myRestaurantState.restaurant.openingHours
          .where((h) => h.dayOfWeek == dayOfWeek && !h.isClosed)
          .firstOrNull;
      if (hours != null) {
        openAt = hours.openAt?.substring(0, 5) ?? '08:00';
        closeAt = hours.closeAt?.substring(0, 5) ?? '22:00';
      }
    }

    final tables = state.tables.isNotEmpty
        ? state.tables.where((t) => t.active).toList()
        : _extractTablesFromReservations(state);

    if (state.isLoading && state.reservations.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (tables.isEmpty) {
      return Center(
          child: Text(S.of(context).noTablesConfigured,
              style: const TextStyle(color: AppColors.textMuted)));
    }

    return ReservationTimelineView(
      tables: tables,
      reservations: state.reservations,
      openAt: openAt,
      closeAt: closeAt,
      selectedDate: state.selectedDate,
      actionInProgressId: state.actionInProgressId,
      onTapReservation: (r) =>
          _showReservationDetail(context, r, state),
    );
  }

  List<StaffTable> _extractTablesFromReservations(
      StaffReservationsState state) {
    final seen = <String>{};
    final tables = <StaffTable>[];
    for (final r in state.reservations) {
      if (seen.add(r.tableId)) {
        tables.add(StaffTable(
          id: r.tableId,
          label: r.tableLabel,
          capacity: 0,
          active: true,
        ));
      }
    }
    return tables;
  }

  void _showReservationDetail(
      BuildContext context, dynamic r, StaffReservationsState state) {
    final bloc = context.read<StaffReservationsBloc>();
    final l = S.of(context);
    final tables = state.tables.isNotEmpty
        ? state.tables.where((t) => t.active).toList()
        : _extractTablesFromReservations(state);

    showReservationDetailSheet(
      context,
      reservation: r,
      isActionInProgress: state.actionInProgressId == r.id,
      availableTables: tables,
      onConfirm: r.canConfirm ? () => bloc.add(ConfirmReservation(r.id)) : null,
      onReject: r.canReject ? () => bloc.add(RejectReservation(r.id)) : null,
      onCheckIn: r.canCheckIn
          ? () => _showConfirmDialog(
                context,
                title: l.checkIn,
                message: l.checkInConfirmMessage,
                onConfirmed: () => bloc.add(CheckInReservation(r.id)),
              )
          : null,
      onComplete: r.canComplete
          ? () => _showConfirmDialog(
                context,
                title: l.complete,
                message: l.completeConfirmMessage,
                onConfirmed: () => bloc.add(CompleteReservation(r.id)),
              )
          : null,
      onEdit: r.canEdit ? () => _showEditSheet(context, r, tables) : null,
    );
  }

  void _showConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onConfirmed,
  }) {
    final l = S.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l.cancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              onConfirmed();
            },
            child: Text(l.confirm),
          ),
        ],
      ),
    );
  }

  void _showEditSheet(
      BuildContext context, dynamic r, List<StaffTable> tables) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<StaffReservationsBloc>(),
        child: StaffEditReservationSheet(
          reservation: r,
          availableTables: tables,
        ),
      ),
    );
  }

}
