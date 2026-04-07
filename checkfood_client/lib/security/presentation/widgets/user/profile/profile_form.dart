import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../domain/entities/user_profile.dart';
import '../../../../../l10n/generated/app_localizations.dart';

/// Formulář pro úpravu jména a příjmení uživatele.
///
/// Po úspěšné validaci volá [onSave] s vyčištěnými hodnotami.
class ProfileForm extends StatefulWidget {
  final UserProfile userProfile;
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
    final l = S.of(context);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _firstNameController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: l.firstName,
              prefixIcon: const Icon(Icons.person_outline),
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l.firstNameRequired;
              }
              return null;
            },
          ),

          const Gap(16),

          TextFormField(
            controller: _lastNameController,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: l.lastName,
              prefixIcon: const Icon(Icons.person_outline),
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l.lastNameRequired;
              }
              return null;
            },
          ),

          const Gap(24),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.onSave(
                    _firstNameController.text.trim(),
                    _lastNameController.text.trim(),
                  );
                }
              },
              child: Text(l.saveChanges),
            ),
          ),
        ],
      ),
    );
  }
}
