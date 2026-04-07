import 'package:flutter/material.dart';

/// Placeholder shown when there is no active check-in context, prompting the
/// user to refresh or start a reservation.
class NoContextWidget extends StatelessWidget {
  final VoidCallback? onRefresh;

  const NoContextWidget({super.key, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.restaurant,
              size: 80,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 24),
            Text(
              'Nemáte aktivní rezervaci',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Pro objednání jídla musíte mít aktivní rezervaci se stavem check-in.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            if (onRefresh != null) ...[
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh),
                label: const Text('Zkontrolovat znovu'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
