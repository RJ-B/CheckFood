import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/theme/colors.dart';

import '../bloc/my_reservations_bloc.dart';
import '../bloc/my_reservations_event.dart';
import '../bloc/my_reservations_state.dart';
import '../widgets/edit_reservation_sheet.dart';
import '../widgets/reservation_card.dart';
import '../../../../../../l10n/generated/app_localizations.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key});

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MyReservationsBloc>().add(const MyReservationsEvent.load());
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
                // ── Upcoming section ──
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
                  ...state.upcoming.map(
                    (r) => ReservationCard(
                      reservation: r,
                      isCancelling: state.cancellingId == r.id,
                      onEdit: () {
                        context.read<MyReservationsBloc>().add(
                              MyReservationsEvent.startEdit(reservation: r),
                            );
                        _showEditSheet(context);
                      },
                      onCancel: () => _showCancelDialog(context, r.id),
                    ),
                  ),

                const SizedBox(height: 24),

                // ── History section ──
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

// ── Section Header ───────────────────────────────────────────────────────

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

// ── Empty State ──────────────────────────────────────────────────────────

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
