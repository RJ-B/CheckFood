import 'package:flutter/material.dart';

import '../../../../../../l10n/generated/app_localizations.dart';
import '../../../../../../core/theme/colors.dart';

/// Souhrnná záložka v dashboardu majitele zobrazující klíčové metriky restaurace
/// (počet zaměstnanců, aktivní stav, dostupnost panoramatu).
class StatisticsTab extends StatelessWidget {
  final int employeeCount;
  final bool isActive;
  final bool hasPanorama;

  const StatisticsTab({
    super.key,
    required this.employeeCount,
    required this.isActive,
    required this.hasPanorama,
  });

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l.statisticsTab,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),
          Card(
            child: ListTile(
              leading: const Icon(Icons.people),
              title: Text(l.employeeCount),
              trailing: Text(
                '$employeeCount',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.store),
              title: Text(l.restaurantStatus),
              trailing: Text(
                isActive ? l.active : l.inactive,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isActive ? AppColors.success : AppColors.textMuted,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.panorama),
              title: Text(l.panoramaStatus),
              trailing: Text(
                hasPanorama ? l.panoramaAvailable : l.panoramaNotAvailable,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: hasPanorama ? AppColors.success : AppColors.textMuted,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                l.moreStatsSoon,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textMuted,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
