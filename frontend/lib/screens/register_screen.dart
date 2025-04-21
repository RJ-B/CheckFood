import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _surname = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _age = TextEditingController();
  final _role = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();

  bool _loading = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrace')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Jméno'),
              ),
              TextFormField(
                controller: _surname,
                decoration: const InputDecoration(labelText: 'Příjmení'),
              ),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _phone,
                decoration: const InputDecoration(labelText: 'Telefon'),
              ),
              TextFormField(
                controller: _age,
                decoration: const InputDecoration(labelText: 'Věk'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _role,
                decoration: const InputDecoration(labelText: 'Role'),
              ),
              TextFormField(
                controller: _username,
                decoration: const InputDecoration(
                  labelText: 'Přihlašovací jméno',
                ),
              ),
              TextFormField(
                controller: _password,
                decoration: const InputDecoration(labelText: 'Heslo'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red)),
              ElevatedButton(
                onPressed:
                    _loading
                        ? null
                        : () async {
                          setState(() {
                            _loading = true;
                            _error = null;
                          });

                          final success = await AuthService.register(
                            name: _name.text,
                            surname: _surname.text,
                            email: _email.text,
                            phone: _phone.text,
                            age: int.tryParse(_age.text),
                            role: _role.text,
                            username: _username.text,
                            password: _password.text,
                          );

                          setState(() => _loading = false);

                          if (success && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Registrace proběhla úspěšně!'),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginScreen(),
                              ),
                            );
                          } else {
                            setState(() => _error = 'Registrace se nezdařila.');
                          }
                        },
                child:
                    _loading
                        ? const CircularProgressIndicator()
                        : const Text('Registrovat'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
