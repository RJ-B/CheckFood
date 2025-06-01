import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), backgroundColor: Colors.blue),
      body: const Center(
        child: Text('Vítej v aplikaci!', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
