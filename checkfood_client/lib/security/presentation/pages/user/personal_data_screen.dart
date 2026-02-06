import 'package:checkfood_client/core/utils/ui_helpers.dart';
// DŮLEŽITÝ IMPORT: Model pro update profilu
import 'package:checkfood_client/security/data/models/profile/request/update_profile_request_model.dart';
import 'package:checkfood_client/security/presentation/bloc/user/user_bloc.dart';
import 'package:checkfood_client/security/presentation/bloc/user/user_event.dart';
import 'package:checkfood_client/security/presentation/bloc/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

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

    // Předvyplnění dat při startu obrazovky
    // Poznámka: Toto funguje, pokud je Bloc již ve stavu 'loaded' (což při přechodu z profilu je).
    final state = context.read<UserBloc>().state;
    state.maybeWhen(
      loaded: (profile) {
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
      // Skrytí klávesnice
      FocusScope.of(context).unfocus();

      // 1. Vytvoření Request Modelu
      final request = UpdateProfileRequestModel(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
      );

      // 2. Odeslání Eventu se zabaleným modelem
      context.read<UserBloc>().add(UserEvent.profileUpdated(request));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Osobní údaje'), centerTitle: true),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          state.maybeWhen(
            // Pokud se update podaří, Bloc emituje nový 'loaded' stav
            // My zde můžeme zobrazit úspěch, ale musíme dát pozor, abychom to nezobrazovali
            // při každém překreslení (proto Listener).
            // V ideálním světě bychom měli speciální stav 'updateSuccess', ale 'loaded' stačí,
            // pokud kontrolujeme změnu dat, nebo prostě spoléháme na uživatele.
            // Zde to raději necháme na 'loaded' s tím, že se zobrazí hláška.
            loaded: (profile) {
              // Zobrazíme hlášku jen pokud jsme právě odeslali formulář (ne při prvním načtení).
              // To je složitější detekovat bez specifického stavu, ale pro teď to necháme takto,
              // nebo použijeme 'AppNotifications' jen pokud jsme si jistí.

              // Lepší varianta: UserBloc by měl po úspěšném updatu emitovat jednorázový side-effect,
              // ale jelikož vrací 'loaded', zobrazí se to pokaždé, když se data načtou.
              // PROZATÍMNÍ ŘEŠENÍ: Zobrazíme jen pokud to dává smysl, nebo použijeme SnackBar přímo.
              if (ModalRoute.of(context)?.isCurrent ?? false) {
                AppNotifications.showSuccess(
                  context,
                  'Údaje byly aktualizovány',
                );
              }
            },
            failure: (message) {
              AppNotifications.showError(context, message);
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            // Zobrazíme formulář i když jsme 'loaded' (editace)
            loaded: (profile) => _buildFormContent(isLoading: false),
            // Pokud se načítá, zobrazíme formulář, ale disable inputy + loader
            loading: () => _buildFormContent(isLoading: true),
            // Fallback pro chybu nebo init
            orElse: () => _buildFormContent(isLoading: false),
          );
        },
      ),
    );
  }

  Widget _buildFormContent({required bool isLoading}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Základní informace',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Zde můžete upravit své jméno a příjmení.',
              style: TextStyle(color: Colors.grey),
            ),
            const Gap(24),

            TextFormField(
              controller: _firstNameController,
              enabled: !isLoading,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Jméno',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Prosím zadejte jméno';
                }
                return null;
              },
            ),
            const Gap(16),

            TextFormField(
              controller: _lastNameController,
              enabled: !isLoading,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Příjmení',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Prosím zadejte příjmení';
                }
                return null;
              },
            ),
            const Gap(16),

            TextFormField(
              controller: _emailController,
              readOnly: true, // Email se obvykle nemění takto jednoduše
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
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
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Text('Uložit změny'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
