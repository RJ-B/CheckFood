import 'package:flutter/material.dart';
import '../../l10n/generated/app_localizations.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Scaffold(body: Center(child: Text(l.orders)));
  }
}
