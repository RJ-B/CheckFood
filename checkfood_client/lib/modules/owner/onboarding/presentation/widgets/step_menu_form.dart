import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/onboarding_wizard_bloc.dart';
import '../bloc/onboarding_wizard_event.dart';
import '../bloc/onboarding_wizard_state.dart';

class StepMenuForm extends StatefulWidget {
  const StepMenuForm({super.key});

  @override
  State<StepMenuForm> createState() => _StepMenuFormState();
}

class _StepMenuFormState extends State<StepMenuForm> {
  bool _loaded = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingWizardBloc, OnboardingWizardState>(
      builder: (context, state) {
        if (!_loaded && !state.loading) {
          _loaded = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<OnboardingWizardBloc>().add(const OnboardingWizardEvent.loadMenu());
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
                  Text('Kategorie (${state.categories.length})',
                      style: Theme.of(context).textTheme.titleMedium),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => _showAddCategoryDialog(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: state.categories.isEmpty
                    ? const Center(child: Text('Zatím žádné kategorie. Přidejte alespoň jednu.'))
                    : ListView.builder(
                        itemCount: state.categories.length,
                        itemBuilder: (ctx, i) {
                          final cat = state.categories[i];
                          return ExpansionTile(
                            title: Text(cat.name),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.add, size: 20),
                                  onPressed: () => _showAddItemDialog(context, cat.id),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, size: 20, color: Colors.red),
                                  onPressed: () => context
                                      .read<OnboardingWizardBloc>()
                                      .add(OnboardingWizardEvent.deleteCategory(cat.id)),
                                ),
                              ],
                            ),
                            children: cat.items.map((item) {
                              return ListTile(
                                title: Text(item.name),
                                subtitle: Text('${(item.priceMinor / 100).toStringAsFixed(0)} ${item.currency}'),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete_outline, size: 20, color: Colors.red),
                                  onPressed: () => context
                                      .read<OnboardingWizardBloc>()
                                      .add(OnboardingWizardEvent.deleteItem(item.id)),
                                ),
                              );
                            }).toList(),
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

  void _showAddCategoryDialog(BuildContext context) {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nová kategorie'),
        content: TextField(controller: ctrl, decoration: const InputDecoration(labelText: 'Název')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Zrušit')),
          FilledButton(
            onPressed: () {
              if (ctrl.text.trim().isNotEmpty) {
                context.read<OnboardingWizardBloc>().add(
                  OnboardingWizardEvent.createCategory(ctrl.text.trim()),
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

  void _showAddItemDialog(BuildContext context, String categoryId) {
    final nameCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nová položka'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Název')),
            const SizedBox(height: 8),
            TextField(controller: descCtrl, decoration: const InputDecoration(labelText: 'Popis')),
            const SizedBox(height: 8),
            TextField(
              controller: priceCtrl,
              decoration: const InputDecoration(labelText: 'Cena (Kč)'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Zrušit')),
          FilledButton(
            onPressed: () {
              if (nameCtrl.text.trim().isNotEmpty) {
                final price = (double.tryParse(priceCtrl.text) ?? 0) * 100;
                context.read<OnboardingWizardBloc>().add(
                  OnboardingWizardEvent.createItem(
                    categoryId: categoryId,
                    name: nameCtrl.text.trim(),
                    description: descCtrl.text.trim().isNotEmpty ? descCtrl.text.trim() : null,
                    priceMinor: price.round(),
                  ),
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
