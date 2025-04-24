import 'package:flutter/material.dart';
import 'package:frontend/services/profile_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  final profileImageController = TextEditingController();

  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await ProfileService.getUserProfile();

    if (userData == null) {
      setState(() => _error = 'Nepodařilo se načíst profil.');
      return;
    }

    setState(() {
      firstNameController.text = userData['firstName'] ?? '';
      lastNameController.text = userData['lastName'] ?? '';
      phoneController.text = userData['phone'] ?? '';
      ageController.text = userData['age']?.toString() ?? '';
      profileImageController.text = userData['profileImage'] ?? '';
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    final success = await ProfileService.updateUserProfile(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      phone: phoneController.text.trim(),
      age: int.tryParse(ageController.text.trim()),
      profileImage: profileImageController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (success) {
      if (!mounted) return;
      Navigator.of(context).pop();
    } else {
      setState(() => _error = 'Aktualizace profilu selhala.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upravit profil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_error != null)
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                TextFormField(
                  controller: firstNameController,
                  decoration: const InputDecoration(labelText: 'Jméno'),
                  validator:
                      (v) => v == null || v.isEmpty ? 'Zadej jméno' : null,
                ),
                TextFormField(
                  controller: lastNameController,
                  decoration: const InputDecoration(labelText: 'Příjmení'),
                  validator:
                      (v) => v == null || v.isEmpty ? 'Zadej příjmení' : null,
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Telefon'),
                ),
                TextFormField(
                  controller: ageController,
                  decoration: const InputDecoration(labelText: 'Věk'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: profileImageController,
                  decoration: const InputDecoration(
                    labelText: 'URL profilové fotky',
                  ),
                ),
                const SizedBox(height: 12),
                profileImageController.text.isNotEmpty
                    ? ClipOval(
                      child: Image.network(
                        profileImageController.text,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) =>
                                const Icon(Icons.image_not_supported),
                      ),
                    )
                    : const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, size: 40, color: Colors.white),
                    ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  child:
                      _isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Uložit změny'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
