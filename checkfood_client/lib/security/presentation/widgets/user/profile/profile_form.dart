import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../domain/entities/user_profile.dart';

class ProfileForm extends StatefulWidget {
  final UserProfile userProfile;
  // Callback nyní vrací obě hodnoty
  final void Function(String firstName, String lastName) onSave;

  const ProfileForm({
    super.key,
    required this.userProfile,
    required this.onSave,
  });

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    // Inicializace kontrolerů surovými daty z entity
    _firstNameController = TextEditingController(
      text: widget.userProfile.firstName,
    );
    _lastNameController = TextEditingController(
      text: widget.userProfile.lastName,
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- JMÉNO ---
          TextFormField(
            controller: _firstNameController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Jméno',
              prefixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Jméno nesmí být prázdné';
              }
              return null;
            },
          ),

          const Gap(16),

          // --- PŘÍJMENÍ ---
          TextFormField(
            controller: _lastNameController,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              labelText: 'Příjmení',
              prefixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Příjmení nesmí být prázdné';
              }
              return null;
            },
          ),

          const Gap(24),

          // --- TLAČÍTKO ULOŽIT ---
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Odesíláme očištěná data zpět do rodičovského widgetu/obrazovky
                  widget.onSave(
                    _firstNameController.text.trim(),
                    _lastNameController.text.trim(),
                  );
                }
              },
              child: const Text('Uložit změny'),
            ),
          ),
        ],
      ),
    );
  }
}
