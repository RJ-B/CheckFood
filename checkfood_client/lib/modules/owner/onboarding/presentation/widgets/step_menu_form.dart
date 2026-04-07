import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../l10n/generated/app_localizations.dart';
import '../bloc/onboarding_wizard_bloc.dart';
import '../bloc/onboarding_wizard_event.dart';
import '../bloc/onboarding_wizard_state.dart';

/// Onboarding step 4: form for building the restaurant's menu by creating categories and adding items with names, descriptions, and prices.
class StepMenuForm extends StatefulWidget {
  const StepMenuForm({super.key});

  @override
  State<StepMenuForm> createState() => _StepMenuFormState();
}

/// State for [StepMenuForm]: triggers the initial menu load and manages dialogs
/// for creating categories and adding items.
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
                  Text(S.of(context).categoriesCount(state.categories.length),
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
                    ? Center(child: Text(S.of(context).noCategoriesYet))
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
                                  icon: const Icon(Icons.delete_outline, size: 20, color: AppColors.error),
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
                                  icon: const Icon(Icons.delete_outline, size: 20, color: AppColors.error),
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
      builder: (ctx) {
        final l = S.of(ctx);
        return AlertDialog(
          title: Text(l.newCategory),
          content: TextField(controller: ctrl, decoration: InputDecoration(labelText: l.categoryName)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l.cancel)),
            FilledButton(
              onPressed: () {
                if (ctrl.text.trim().isNotEmpty) {
                  context.read<OnboardingWizardBloc>().add(
                    OnboardingWizardEvent.createCategory(ctrl.text.trim()),
                  );
                  Navigator.pop(ctx);
                }
              },
              child: Text(l.add),
            ),
          ],
        );
      },
    );
  }

  void _showAddItemDialog(BuildContext context, String categoryId) {
    final nameCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) {
        final l = S.of(ctx);
        return AlertDialog(
          title: Text(l.newItem),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl, decoration: InputDecoration(labelText: l.itemName)),
              const SizedBox(height: 8),
              TextField(controller: descCtrl, decoration: InputDecoration(labelText: l.itemDescription)),
              const SizedBox(height: 8),
              TextField(
                controller: priceCtrl,
                decoration: InputDecoration(labelText: l.priceLabel),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l.cancel)),
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
              child: Text(l.add),
            ),
          ],
        );
      },
    );
  }
}
