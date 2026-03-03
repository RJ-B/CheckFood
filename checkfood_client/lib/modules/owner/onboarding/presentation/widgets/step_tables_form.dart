import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/onboarding_wizard_bloc.dart';
import '../bloc/onboarding_wizard_event.dart';
import '../bloc/onboarding_wizard_state.dart';

class StepTablesForm extends StatefulWidget {
  const StepTablesForm({super.key});

  @override
  State<StepTablesForm> createState() => _StepTablesFormState();
}

class _StepTablesFormState extends State<StepTablesForm> {
  bool _loaded = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingWizardBloc, OnboardingWizardState>(
      builder: (context, state) {
        if (!_loaded && !state.loading) {
          _loaded = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<OnboardingWizardBloc>().add(const OnboardingWizardEvent.loadTables());
          });
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Stoly (${state.tables.length})',
                      style: Theme.of(context).textTheme.titleMedium),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => _showAddDialog(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: state.tables.isEmpty
                    ? const Center(child: Text('Zatím žádné stoly. Přidejte alespoň jeden.'))
                    : ListView.builder(
                        itemCount: state.tables.length,
                        itemBuilder: (ctx, i) {
                          final table = state.tables[i];
                          return Card(
                            child: ListTile(
                              title: Text(table.label),
                              subtitle: Text('Kapacita: ${table.capacity}'),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.red),
                                onPressed: () => context
                                    .read<OnboardingWizardBloc>()
                                    .add(OnboardingWizardEvent.deleteTable(table.id)),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddDialog(BuildContext context) {
    final labelCtrl = TextEditingController();
    final capacityCtrl = TextEditingController(text: '4');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Přidat stůl'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: labelCtrl, decoration: const InputDecoration(labelText: 'Označení')),
            const SizedBox(height: 8),
            TextField(
              controller: capacityCtrl,
              decoration: const InputDecoration(labelText: 'Kapacita'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Zrušit')),
          FilledButton(
            onPressed: () {
              final label = labelCtrl.text.trim();
              final capacity = int.tryParse(capacityCtrl.text) ?? 4;
              if (label.isNotEmpty) {
                context.read<OnboardingWizardBloc>().add(
                  OnboardingWizardEvent.addTable(label: label, capacity: capacity),
                );
                Navigator.pop(ctx);
              }
            },
            child: const Text('Přidat'),
          ),
        ],
      ),
    );
  }
}
