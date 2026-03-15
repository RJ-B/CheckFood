import 'package:flutter/material.dart';

import '../../../../../l10n/generated/app_localizations.dart';
import '../../data/models/request/update_restaurant_request_model.dart';
import '../../domain/entities/my_restaurant.dart';

class RestaurantInfoForm extends StatefulWidget {
  final MyRestaurant restaurant;
  final bool isUpdating;
  final void Function(UpdateRestaurantRequestModel request) onSubmit;

  const RestaurantInfoForm({
    super.key,
    required this.restaurant,
    required this.isUpdating,
    required this.onSubmit,
  });

  @override
  State<RestaurantInfoForm> createState() => _RestaurantInfoFormState();
}

class _RestaurantInfoFormState extends State<RestaurantInfoForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _streetController;
  late TextEditingController _cityController;
  late TextEditingController _postalCodeController;
  late TextEditingController _countryController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.restaurant.name);
    _descriptionController = TextEditingController(text: widget.restaurant.description ?? '');
    _phoneController = TextEditingController(text: widget.restaurant.phone ?? '');
    _emailController = TextEditingController(text: widget.restaurant.contactEmail ?? '');
    _streetController = TextEditingController(text: widget.restaurant.address.street);
    _cityController = TextEditingController(text: widget.restaurant.address.city);
    _postalCodeController = TextEditingController(text: widget.restaurant.address.postalCode ?? '');
    _countryController = TextEditingController(text: widget.restaurant.address.country);
  }

  @override
  void didUpdateWidget(covariant RestaurantInfoForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.restaurant.id != widget.restaurant.id) {
      _nameController.text = widget.restaurant.name;
      _descriptionController.text = widget.restaurant.description ?? '';
      _phoneController.text = widget.restaurant.phone ?? '';
      _emailController.text = widget.restaurant.contactEmail ?? '';
      _streetController.text = widget.restaurant.address.street;
      _cityController.text = widget.restaurant.address.city;
      _postalCodeController.text = widget.restaurant.address.postalCode ?? '';
      _countryController.text = widget.restaurant.address.country;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l.restaurantInfo,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),

            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: l.nameLabel,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.restaurant),
              ),
              validator: (v) => (v == null || v.isEmpty) ? l.nameRequired : null,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: l.descriptionLabel,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.description),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: l.phoneLabel,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: l.contactEmailLabel,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),

            Text(
              l.addressLabel,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _streetController,
              decoration: InputDecoration(
                labelText: l.streetLabel,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      labelText: l.cityLabel,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _postalCodeController,
                    decoration: InputDecoration(
                      labelText: l.postalCodeLabel,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _countryController,
              decoration: InputDecoration(
                labelText: l.countryLabel,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),

            FilledButton.icon(
              onPressed: widget.isUpdating ? null : _submit,
              icon: widget.isUpdating
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.save),
              label: Text(widget.isUpdating ? l.savingLabel : l.saveChanges),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit(
        UpdateRestaurantRequestModel(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim().isNotEmpty
              ? _descriptionController.text.trim()
              : null,
          phone: _phoneController.text.trim().isNotEmpty
              ? _phoneController.text.trim()
              : null,
          email: _emailController.text.trim().isNotEmpty
              ? _emailController.text.trim()
              : null,
          address: {
            'street': _streetController.text.trim(),
            'city': _cityController.text.trim(),
            'postalCode': _postalCodeController.text.trim(),
            'country': _countryController.text.trim(),
          },
        ),
      );
    }
  }
}
