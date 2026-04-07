import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/theme/colors.dart';

import '../../domain/entities/reservation.dart';
import '../bloc/my_reservations_bloc.dart';
import '../bloc/my_reservations_event.dart';
import '../bloc/my_reservations_state.dart';
import '../widgets/edit_reservation_sheet.dart';
import '../widgets/reservation_card.dart';
import '../../../../../../l10n/generated/app_localizations.dart';

/// Screen displaying the user's upcoming and past reservations with support for
/// editing, cancelling, responding to pending change proposals, and creating recurring reservations.
class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key});

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

/// State for [ReservationsScreen]: triggers the initial load of reservations
/// and pending changes on mount.
class _ReservationsScreenState extends State<ReservationsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MyReservationsBloc>()
      ..add(const MyReservationsEvent.load())
      ..add(const MyReservationsEvent.loadPendingChanges());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).myReservations)),
      body: BlocConsumer<MyReservationsBloc, MyReservationsState>(
        listener: (context, state) {
          final l = S.of(context);
          if (state.cancelSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l.reservationCancelled),
                backgroundColor: AppColors.success,
              ),
            );
          }
          if (state.editSuccess) {
            Navigator.of(context).popUntil(
              (route) => route.settings.name != null || route.isFirst,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l.reservationEdited),
                backgroundColor: AppColors.success,
              ),
            );
          }
        },
        builder: (context, state) {
          final l = S.of(context);
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.loadError != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: AppColors.error, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    state.loadError!,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context
                        .read<MyReservationsBloc>()
                        .add(const MyReservationsEvent.load()),
                    child: Text(l.retry),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<MyReservationsBloc>()
                  .add(const MyReservationsEvent.refresh());
            },
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
                _SectionHeader(
                  title: l.upcoming,
                  icon: Icons.event_available,
                ),
                if (state.upcoming.isEmpty)
                  _EmptyState(
                    message: l.noUpcomingReservations,
                    icon: Icons.calendar_today_outlined,
                  )
                else
                  ...state.upcoming.map((r) {
                    final pendingChange = state.pendingChanges
                        .where((c) => c.reservationId == r.id)
                        .firstOrNull;
                    return ReservationCard(
                      reservation: r,
                      isCancelling: state.cancellingId == r.id,
                      pendingChange: pendingChange,
                      isPendingChangeLoading:
                          state.pendingChangeActionId != null &&
                          pendingChange != null &&
                          state.pendingChangeActionId == pendingChange.id,
                      onAcceptChange: pendingChange != null
                          ? () => context.read<MyReservationsBloc>().add(
                                MyReservationsEvent.acceptChangeRequest(
                                    changeRequestId: pendingChange.id),
                              )
                          : null,
                      onDeclineChange: pendingChange != null
                          ? () => context.read<MyReservationsBloc>().add(
                                MyReservationsEvent.declineChangeRequest(
                                    changeRequestId: pendingChange.id),
                              )
                          : null,
                      onEdit: () {
                        context.read<MyReservationsBloc>().add(
                              MyReservationsEvent.startEdit(reservation: r),
                            );
                        _showEditSheet(context);
                      },
                      onCancel: () => _showCancelDialog(context, r.id),
                      onCreateRecurring: () => _showCreateRecurringDialog(context, r),
                    );
                  }),

                const SizedBox(height: 24),

                _SectionHeader(
                  title: l.history,
                  icon: Icons.history,
                ),
                if (state.history.isEmpty)
                  _EmptyState(
                    message: l.noReservationHistory,
                    icon: Icons.history_outlined,
                  )
                else ...[
                  ...state.history.map(
                    (r) => ReservationCard(
                      reservation: r,
                      isCancelling: false,
                      onEdit: null,
                      onCancel: null,
                      onCreateRecurring: () => _showCreateRecurringDialog(context, r),
                    ),
                  ),
                  if (!state.showingAllHistory &&
                      state.totalHistoryCount > state.history.length)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: state.isLoadingHistory
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : OutlinedButton(
                              onPressed: () => context
                                  .read<MyReservationsBloc>()
                                  .add(const MyReservationsEvent
                                      .showAllHistory()),
                              child: Text(
                                l.showAll(state.totalHistoryCount),
                              ),
                            ),
                    ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  void _showEditSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<MyReservationsBloc>(),
        child: const EditReservationSheet(),
      ),
    );
  }

  void _showCreateRecurringDialog(BuildContext context, Reservation reservation) {
    final days = ['Pondělí', 'Úterý', 'Středa', 'Čtvrtek', 'Pátek', 'Sobota', 'Neděle'];
    final resDate = DateTime.tryParse(reservation.date ?? '');
    int selectedDay = resDate != null ? resDate.weekday : 1;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Vytvořit opakovanou rezervaci'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${reservation.restaurantName ?? "Restaurace"} — ${reservation.tableLabel ?? "Stůl"}',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                'Čas: ${reservation.startTime?.substring(0, 5) ?? ""}',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
              const SizedBox(height: 16),
              const Text('Den v týdnu:', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              DropdownButtonFormField<int>(
                value: selectedDay,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
                items: List.generate(7, (i) => DropdownMenuItem(
                  value: i + 1,
                  child: Text(days[i]),
                )),
                onChanged: (val) => setDialogState(() => selectedDay = val ?? selectedDay),
              ),
              const SizedBox(height: 12),
              Text(
                'Rezervace bude čekat na potvrzení od restaurace.',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Zrušit'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(ctx);
                context.read<MyReservationsBloc>().add(
                  MyReservationsEvent.createRecurring(
                    restaurantId: reservation.restaurantId ?? '',
                    tableId: reservation.tableId ?? '',
                    dayOfWeek: selectedDay.toString(),
                    startTime: reservation.startTime?.substring(0, 5) ?? '18:00',
                    partySize: reservation.partySize ?? 2,
                  ),
                );
              },
              child: const Text('Vytvořit'),
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context, String reservationId) {
    final l = S.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l.cancelReservation),
        content: Text(l.cancelReservationConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l.no),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<MyReservationsBloc>().add(
                    MyReservationsEvent.cancel(reservationId: reservationId),
                  );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(l.yesCancelIt),
          ),
        ],
      ),
    );
  }
}

/// A section heading row with a leading icon and title text.
class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

/// A centred placeholder shown when a section has no items.
class _EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;

  const _EmptyState({required this.message, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Icon(icon, size: 48, color: AppColors.textMuted),
          const SizedBox(height: 12),
          Text(
            message,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
