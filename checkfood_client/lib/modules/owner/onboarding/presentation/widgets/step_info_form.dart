import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/address_model.dart';
import '../bloc/onboarding_wizard_bloc.dart';
import '../bloc/onboarding_wizard_event.dart';
import '../bloc/onboarding_wizard_state.dart';

class StepInfoForm extends StatefulWidget {
  const StepInfoForm({super.key});

  @override
  State<StepInfoForm> createState() => _StepInfoFormState();
}

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
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameCtrl,
                  decoration: const InputDecoration(labelText: 'Název restaurace *'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Povinné pole' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descCtrl,
                  decoration: const InputDecoration(labelText: 'Popis'),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _phoneCtrl,
                  decoration: const InputDecoration(labelText: 'Telefon'),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(labelText: 'Kontaktní e-mail'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _cuisineType,
                  decoration: const InputDecoration(labelText: 'Typ kuchyně'),
                  items: _cuisineTypes
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (v) => setState(() => _cuisineType = v),
                ),
                const SizedBox(height: 16),
                const Text('Adresa', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _streetCtrl,
                  decoration: const InputDecoration(labelText: 'Ulice *'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Povinné pole' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _cityCtrl,
                  decoration: const InputDecoration(labelText: 'Město *'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Povinné pole' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _postalCtrl,
                  decoration: const InputDecoration(labelText: 'PSČ'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: state.loading ? null : _submit,
                  child: state.loading
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Uložit informace'),
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
