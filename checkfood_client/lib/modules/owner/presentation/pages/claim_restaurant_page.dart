import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../bloc/owner_claim_bloc.dart';
import '../bloc/owner_claim_event.dart';
import '../bloc/owner_claim_state.dart';

class ClaimRestaurantPage extends StatelessWidget {
  const ClaimRestaurantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<OwnerClaimBloc>(),
      child: const _ClaimRestaurantView(),
    );
  }
}

class _ClaimRestaurantView extends StatefulWidget {
  const _ClaimRestaurantView();

  @override
  State<_ClaimRestaurantView> createState() => _ClaimRestaurantViewState();
}

class _ClaimRestaurantViewState extends State<_ClaimRestaurantView> {
  final _icoController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _icoController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Přiřazení restaurace'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocConsumer<OwnerClaimBloc, OwnerClaimState>(
        listener: (context, state) {
          if (state.claimSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Restaurace byla úspěšně přiřazena!'),
                backgroundColor: Colors.green.shade600,
                behavior: SnackBarBehavior.floating,
              ),
            );
            // Navigate to main after successful claim
            Navigator.of(context).pushNamedAndRemoveUntil('/', (r) => false);
          }
          if (state.aresError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.aresError!),
                backgroundColor: theme.colorScheme.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
          if (state.claimError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.claimError!),
                backgroundColor: theme.colorScheme.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.store_rounded,
                    size: 64,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Vyhledejte svou restauraci',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Zadejte IČO vaší firmy pro vyhledání v ARES',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Step 1: ICO input
                  _buildIcoInput(context, state, theme),

                  // Step 2: Company info + BankID
                  if (state.aresCompany != null) ...[
                    const SizedBox(height: 24),
                    _buildCompanyInfo(context, state, theme),
                  ],

                  // Step 3: Email fallback
                  if (state.claimResult != null &&
                      !state.claimResult!.matched &&
                      state.claimResult!.emailFallbackAvailable) ...[
                    const SizedBox(height: 24),
                    _buildEmailFallback(context, state, theme),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIcoInput(
    BuildContext context,
    OwnerClaimState state,
    ThemeData theme,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _icoController,
              decoration: const InputDecoration(
                labelText: 'IČO firmy',
                hintText: 'např. 12345678',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              maxLength: 8,
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: state.loading
                  ? null
                  : () {
                      final ico = _icoController.text.trim();
                      if (ico.length == 8) {
                        context.read<OwnerClaimBloc>().add(
                          OwnerClaimEvent.lookupAres(ico: ico),
                        );
                      }
                    },
              icon: state.loading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.search),
              label: const Text('Vyhledat v ARES'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyInfo(
    BuildContext context,
    OwnerClaimState state,
    ThemeData theme,
  ) {
    final company = state.aresCompany!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Nalezená firma',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _infoRow('Název:', company.companyName),
            _infoRow('IČO:', company.ico),
            if (company.statutoryPersons.isNotEmpty)
              _infoRow(
                'Jednatelé:',
                company.statutoryPersons.join(', '),
              ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: state.bankIdVerifying
                  ? null
                  : () {
                      context.read<OwnerClaimBloc>().add(
                        const OwnerClaimEvent.verifyBankId(),
                      );
                    },
              icon: state.bankIdVerifying
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.verified_user),
              label: const Text('Ověřit identitu (BankID)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailFallback(
    BuildContext context,
    OwnerClaimState state,
    ThemeData theme,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Ověření e-mailem',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Identita nebyla potvrzena přes BankID. '
              'Můžete ověřit vlastnictví kódem zaslaným na kontaktní e-mail restaurace.',
              style: theme.textTheme.bodyMedium,
            ),
            if (state.claimResult?.emailHint != null) ...[
              const SizedBox(height: 4),
              Text(
                'E-mail: ${state.claimResult!.emailHint}',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
            const SizedBox(height: 12),
            if (!state.emailCodeSent) ...[
              ElevatedButton(
                onPressed: state.emailSending
                    ? null
                    : () {
                        context.read<OwnerClaimBloc>().add(
                          const OwnerClaimEvent.startEmailClaim(),
                        );
                      },
                child: state.emailSending
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Odeslat ověřovací kód'),
              ),
            ] else ...[
              TextField(
                controller: _codeController,
                decoration: const InputDecoration(
                  labelText: 'Ověřovací kód',
                  hintText: '123456',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                maxLength: 6,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: state.emailConfirming
                    ? null
                    : () {
                        final code = _codeController.text.trim();
                        if (code.length == 6) {
                          context.read<OwnerClaimBloc>().add(
                            OwnerClaimEvent.confirmEmailCode(code: code),
                          );
                        }
                      },
                child: state.emailConfirming
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Potvrdit kód'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
