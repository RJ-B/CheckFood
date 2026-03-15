import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../../data/models/profile/request/update_profile_request_model.dart';
import '../../bloc/user/user_bloc.dart';
import '../../bloc/user/user_event.dart';
import '../../bloc/user/user_state.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({super.key});

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();

    // Předvyplnění dat.
    // Protože sem jdeme z profilu, kde jsou data načtená, můžeme je rovnou vzít.
    final state = context.read<UserBloc>().state;
    state.maybeWhen(
      loaded: (profile, _, __, ___) {
        // Ignorujeme devices
        _firstNameController.text = profile.firstName;
        _lastNameController.text = profile.lastName;
        _emailController.text = profile.email;
      },
      orElse: () {},
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      final request = UpdateProfileRequestModel(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
      );

      context.read<UserBloc>().add(UserEvent.profileUpdated(request));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.personalData), centerTitle: true),
      body: BlocConsumer<UserBloc, UserState>(
        listenWhen: (previous, current) {
          return previous.maybeMap(loading: (_) => true, orElse: () => false);
        },
        listener: (context, state) {
          state.maybeWhen(
            loaded: (profile, _, __, ___) {
              if (ModalRoute.of(context)?.isCurrent ?? false) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l.profileUpdated),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            failure: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          final bool isLoading = state.maybeMap(
            loading: (_) => true,
            orElse: () => false,
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.basicInfo,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    l.basicInfoSubtitle,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Gap(24),

                  TextFormField(
                    controller: _firstNameController,
                    enabled: !isLoading,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: l.firstName,
                      prefixIcon: const Icon(Icons.person_outline),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l.enterFirstName;
                      }
                      return null;
                    },
                  ),
                  const Gap(16),

                  TextFormField(
                    controller: _lastNameController,
                    enabled: !isLoading,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: l.lastName,
                      prefixIcon: const Icon(Icons.person_outline),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l.enterLastName;
                      }
                      return null;
                    },
                  ),
                  const Gap(16),

                  TextFormField(
                    controller: _emailController,
                    readOnly: true,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: l.email,
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: const OutlineInputBorder(),
                      filled: true,
                    ),
                  ),
                  const Gap(32),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submit,
                      child:
                          isLoading
                              ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                              : Text(l.saveChanges),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
