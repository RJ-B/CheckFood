import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../l10n/generated/app_localizations.dart';
import '../../data/models/address_model.dart';
import '../bloc/onboarding_wizard_bloc.dart';
import '../bloc/onboarding_wizard_event.dart';
import '../bloc/onboarding_wizard_state.dart';

/// Onboarding step 1: form for entering the restaurant's basic info (name,
/// description, contact details, address, and cuisine type).
class StepInfoForm extends StatefulWidget {
  const StepInfoForm({super.key});

  @override
  State<StepInfoForm> createState() => _StepInfoFormState();
}

/// State for [StepInfoForm]: owns the text controllers and pre-fills them from
/// the existing restaurant data on first render.
class _StepInfoFormState extends State<StepInfoForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _streetCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _postalCtrl = TextEditingController();
  String? _cuisineType;
  bool _initialized = false;

  static const _cuisineTypes = [
    'CZECH', 'ITALIAN', 'CHINESE', 'JAPANESE', 'INDIAN',
    'MEXICAN', 'THAI', 'FRENCH', 'AMERICAN', 'OTHER',
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _streetCtrl.dispose();
    _cityCtrl.dispose();
    _postalCtrl.dispose();
    super.dispose();
  }

  void _initFromState(OnboardingWizardState state) {
    if (_initialized || state.restaurant == null) return;
    _initialized = true;
    final r = state.restaurant!;
    _nameCtrl.text = r.name ?? '';
    _descCtrl.text = r.description ?? '';
    _phoneCtrl.text = '';
    _emailCtrl.text = '';
    _streetCtrl.text = r.address?.street ?? '';
    _cityCtrl.text = r.address?.city ?? '';
    _postalCtrl.text = r.address?.postalCode ?? '';
    _cuisineType = r.cuisineType;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingWizardBloc, OnboardingWizardState>(
      builder: (context, state) {
        _initFromState(state);
        final l = S.of(context);
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameCtrl,
                  decoration: InputDecoration(labelText: l.restaurantNameRequired),
                  validator: (v) => (v == null || v.isEmpty) ? l.requiredField : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descCtrl,
                  decoration: InputDecoration(labelText: l.description),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _phoneCtrl,
                  decoration: InputDecoration(labelText: l.phone),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailCtrl,
                  decoration: InputDecoration(labelText: l.contactEmail),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _cuisineType,
                  decoration: InputDecoration(labelText: l.cuisineType),
                  items: _cuisineTypes
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (v) => setState(() => _cuisineType = v),
                ),
                const SizedBox(height: 16),
                Text(l.address, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _streetCtrl,
                  decoration: InputDecoration(labelText: l.streetRequired),
                  validator: (v) => (v == null || v.isEmpty) ? l.requiredField : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _cityCtrl,
                  decoration: InputDecoration(labelText: l.cityRequired),
                  validator: (v) => (v == null || v.isEmpty) ? l.requiredField : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _postalCtrl,
                  decoration: InputDecoration(labelText: l.postalCode),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: state.loading ? null : _submit,
                  child: state.loading
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : Text(l.saveInfo),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<OnboardingWizardBloc>().add(
      OnboardingWizardEvent.updateInfo(
        name: _nameCtrl.text,
        description: _descCtrl.text.isNotEmpty ? _descCtrl.text : null,
        phone: _phoneCtrl.text.isNotEmpty ? _phoneCtrl.text : null,
        email: _emailCtrl.text.isNotEmpty ? _emailCtrl.text : null,
        address: AddressModel(
          street: _streetCtrl.text,
          city: _cityCtrl.text,
          postalCode: _postalCtrl.text.isNotEmpty ? _postalCtrl.text : null,
        ),
        cuisineType: _cuisineType,
      ),
    );
  }
}
