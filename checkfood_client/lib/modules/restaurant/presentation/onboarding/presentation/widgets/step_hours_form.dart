import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/colors.dart';
import '../../../../../../l10n/generated/app_localizations.dart';
import '../../data/models/opening_hours_model.dart';
import '../bloc/onboarding_wizard_bloc.dart';
import '../bloc/onboarding_wizard_event.dart';
import '../bloc/onboarding_wizard_state.dart';

/// Onboarding krok 2: formulář pro konfiguraci týdenních otevíracích dob restaurace.
class StepHoursForm extends StatefulWidget {
  const StepHoursForm({super.key});

  @override
  State<StepHoursForm> createState() => _StepHoursFormState();
}

/// State pro [StepHoursForm]: udržuje časy otevření/zavření pro každý den
/// a inicializuje je z existujících dat restaurace při prvním vykreslení.
class _StepHoursFormState extends State<StepHoursForm> {
  static const _dayNames = ['MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY', 'SUNDAY'];

  final Map<String, bool> _closed = {};
  final Map<String, TimeOfDay> _openAt = {};
  final Map<String, TimeOfDay> _closeAt = {};
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    for (final day in _dayNames) {
      _closed[day] = false;
      _openAt[day] = const TimeOfDay(hour: 10, minute: 0);
      _closeAt[day] = const TimeOfDay(hour: 22, minute: 0);
    }
  }

  void _initFromState(OnboardingWizardState state) {
    if (_initialized || state.restaurant == null) return;
    _initialized = true;
    for (final oh in state.restaurant!.openingHours) {
      final day = oh.dayOfWeek;
      _closed[day] = oh.closed;
      if (oh.openAt != null) {
        final parts = oh.openAt!.split(':');
        _openAt[day] = TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
      }
      if (oh.closeAt != null) {
        final parts = oh.closeAt!.split(':');
        _closeAt[day] = TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final dayLabels = [
      l.dayMonday, l.dayTuesday, l.dayWednesday, l.dayThursday,
      l.dayFriday, l.daySaturday, l.daySunday,
    ];
    return BlocBuilder<OnboardingWizardBloc, OnboardingWizardState>(
      builder: (context, state) {
        _initFromState(state);
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < _dayNames.length; i++) _buildDayRow(context, i, dayLabels),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: state.loading ? null : _submit,
                child: state.loading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : Text(l.saveHours),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDayRow(BuildContext context, int index, List<String> dayLabels) {
    final day = _dayNames[index];
    final label = dayLabels[index];
    final closed = _closed[day]!;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            SizedBox(width: 80, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500))),
            Switch(
              value: !closed,
              onChanged: (v) => setState(() => _closed[day] = !v),
            ),
            if (!closed) ...[
              const SizedBox(width: 8),
              _timeButton(day, true),
              const Text(' - '),
              _timeButton(day, false),
            ] else
              Text(S.of(context).closedDay, style: const TextStyle(color: AppColors.textMuted)),
          ],
        ),
      ),
    );
  }

  Widget _timeButton(String day, bool isOpen) {
    final time = isOpen ? _openAt[day]! : _closeAt[day]!;
    return TextButton(
      onPressed: () async {
        final picked = await showTimePicker(context: context, initialTime: time);
        if (picked != null) {
          setState(() {
            if (isOpen) {
              _openAt[day] = picked;
            } else {
              _closeAt[day] = picked;
            }
          });
        }
      },
      child: Text(time.format(context)),
    );
  }

  String _formatTime(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  void _submit() {
    final hours = _dayNames.map((day) {
      return OpeningHoursModel(
        dayOfWeek: day,
        openAt: _closed[day]! ? null : _formatTime(_openAt[day]!),
        closeAt: _closed[day]! ? null : _formatTime(_closeAt[day]!),
        closed: _closed[day]!,
      );
    }).toList();

    context.read<OnboardingWizardBloc>().add(OnboardingWizardEvent.updateHours(hours));
  }
}
