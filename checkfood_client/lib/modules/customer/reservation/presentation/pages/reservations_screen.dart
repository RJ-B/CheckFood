import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/my_reservations_bloc.dart';
import '../bloc/my_reservations_event.dart';
import '../bloc/my_reservations_state.dart';
import '../widgets/edit_reservation_sheet.dart';
import '../widgets/reservation_card.dart';

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
      appBar: AppBar(title: const Text('Moje rezervace')),
      body: BlocConsumer<MyReservationsBloc, MyReservationsState>(
        listener: (context, state) {
          if (state.cancelSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Rezervace zrušena.'),
                backgroundColor: Colors.green,
              ),
            );
          }
          if (state.editSuccess) {
            Navigator.of(context).popUntil(
              (route) => route.settings.name != null || route.isFirst,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Rezervace upravena.'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.loadError != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    state.loadError!,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context
                        .read<MyReservationsBloc>()
                        .add(const MyReservationsEvent.load()),
                    child: const Text('Zkusit znovu'),
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
                  title: 'Nadcházející',
                  icon: Icons.event_available,
                ),
                if (state.upcoming.isEmpty)
                  const _EmptyState(
                    message: 'Žádné nadcházející rezervace',
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
                  title: 'Historie',
                  icon: Icons.history,
                ),
                if (state.history.isEmpty)
                  const _EmptyState(
                    message: 'Žádná historie rezervací',
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
                                'Zobrazit vše (${state.totalHistoryCount})',
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
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Zrušit rezervaci'),
        content: const Text('Opravdu chcete zrušit tuto rezervaci?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Ne'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<MyReservationsBloc>().add(
                    MyReservationsEvent.cancel(reservationId: reservationId),
                  );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Ano, zrušit'),
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
          Icon(icon, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 12),
          Text(
            message,
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
        ],
      ),
    );
  }
}
