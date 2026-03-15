import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../l10n/generated/app_localizations.dart';

import '../bloc/staff_reservations_bloc.dart';
import '../bloc/staff_reservations_event.dart';
import '../bloc/staff_reservations_state.dart';
import '../widgets/staff_reservation_card.dart';

class StaffReservationsPage extends StatefulWidget {
  const StaffReservationsPage({super.key});

  @override
  State<StaffReservationsPage> createState() => _StaffReservationsPageState();
}

class _StaffReservationsPageState extends State<StaffReservationsPage> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<StaffReservationsBloc>();
    bloc.add(LoadStaffReservations(bloc.state.selectedDate));
    bloc.startPolling();
  }

  @override
  void dispose() {
    // stopPolling is handled by bloc.close()
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StaffReservationsBloc, StaffReservationsState>(
      listener: (context, state) {
        if (state.actionError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.actionError!),
              backgroundColor: Colors.red.shade700,
            ),
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            _DatePickerRow(
              selectedDate: state.selectedDate,
              onDateChanged: (date) {
                context
                    .read<StaffReservationsBloc>()
                    .add(ChangeDate(date));
              },
            ),
            Expanded(child: _buildBody(context, state)),
          ],
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, StaffReservationsState state) {
    if (state.isLoading && state.reservations.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.reservations.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 12),
            Text(state.error!, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () => context
                  .read<StaffReservationsBloc>()
                  .add(LoadStaffReservations(state.selectedDate)),
              icon: const Icon(Icons.refresh),
              label: Text(S.of(context).retry),
            ),
          ],
        ),
      );
    }

    if (state.reservations.isEmpty) {
      return Center(
        child: Text(S.of(context).noReservationsForDayStaff,
            style: const TextStyle(color: Colors.grey)),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<StaffReservationsBloc>()
            .add(LoadStaffReservations(state.selectedDate));
        // Wait a bit for the state to update
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 16),
        itemCount: state.reservations.length,
        itemBuilder: (context, index) {
          final r = state.reservations[index];
          return StaffReservationCard(
            reservation: r,
            isActionInProgress: state.actionInProgressId == r.id,
            onConfirm: r.canConfirm
                ? () => context
                    .read<StaffReservationsBloc>()
                    .add(ConfirmReservation(r.id))
                : null,
            onReject: r.canReject
                ? () => context
                    .read<StaffReservationsBloc>()
                    .add(RejectReservation(r.id))
                : null,
            onCheckIn: r.canCheckIn
                ? () => context
                    .read<StaffReservationsBloc>()
                    .add(CheckInReservation(r.id))
                : null,
            onComplete: r.canComplete
                ? () => context
                    .read<StaffReservationsBloc>()
                    .add(CompleteReservation(r.id))
                : null,
          );
        },
      ),
    );
  }
}

class _DatePickerRow extends StatelessWidget {
  final String selectedDate;
  final ValueChanged<String> onDateChanged;

  const _DatePickerRow({
    required this.selectedDate,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateTime.tryParse(selectedDate) ?? DateTime.now();
    final formatter = DateFormat('EEE, d MMM yyyy', 'cs');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              final prev = date.subtract(const Duration(days: 1));
              onDateChanged(DateFormat('yyyy-MM-dd').format(prev));
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
                );
                if (picked != null) {
                  onDateChanged(DateFormat('yyyy-MM-dd').format(picked));
                }
              },
              child: Text(
                formatter.format(date),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              final next = date.add(const Duration(days: 1));
              onDateChanged(DateFormat('yyyy-MM-dd').format(next));
            },
          ),
        ],
      ),
    );
  }
}
