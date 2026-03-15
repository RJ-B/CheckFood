import 'package:flutter/material.dart';
import '../../l10n/generated/app_localizations.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Scaffold(body: Center(child: Text(l.favorites)));
  }
}
