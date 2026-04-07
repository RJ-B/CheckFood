import 'package:flutter/material.dart';

import '../../../../../l10n/generated/app_localizations.dart';
import '../../../../../core/theme/colors.dart';
import '../../data/models/request/update_restaurant_request_model.dart';
import '../../domain/entities/my_restaurant.dart';
import 'panorama_tab.dart';

/// An expandable settings form for editing the restaurant's name, description,
/// contact info, address, opening hours, special days, and reservation defaults.
class RestaurantInfoForm extends StatefulWidget {
  final MyRestaurant restaurant;
  final bool isUpdating;
  final void Function(UpdateRestaurantRequestModel request) onSubmit;
  final String? panoramaUrl;
  final bool isOwner;

  /// Called whenever the form transitions between dirty and clean state.
  final ValueChanged<bool>? onDirtyChanged;

  const RestaurantInfoForm({
    super.key,
    required this.restaurant,
    required this.isUpdating,
    required this.onSubmit,
    this.panoramaUrl,
    this.isOwner = false,
    this.onDirtyChanged,
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
  late int _selectedDuration;
  late List<_DayHours> _openingHours;
  late List<_SpecialDay> _specialDays;

  final _section1Controller = ExpansionTileController();
  final _section2Controller = ExpansionTileController();
  final _section3Controller = ExpansionTileController();
  final _section4Controller = ExpansionTileController();

  bool _isDirty = false;

  void _markDirty() {
    if (!_isDirty) {
      _isDirty = true;
      widget.onDirtyChanged?.call(true);
    }
  }

  void _markClean() {
    if (_isDirty) {
      _isDirty = false;
      widget.onDirtyChanged?.call(false);
    }
  }

  static const _dayNames = ['Pondělí', 'Úterý', 'Středa', 'Čtvrtek', 'Pátek', 'Sobota', 'Neděle'];
  static final _timeOptions = List.generate(48, (i) {
    final hour = i ~/ 2;
    final minute = (i % 2) * 30;
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  })..add('23:59');

  @override
  void initState() {
    super.initState();
    _selectedDuration = widget.restaurant.defaultReservationDurationMinutes;
    _initOpeningHours();
    _initSpecialDays();
    _nameController = TextEditingController(text: widget.restaurant.name);
    _descriptionController = TextEditingController(text: widget.restaurant.description ?? '');
    _phoneController = TextEditingController(text: widget.restaurant.phone ?? '');
    _emailController = TextEditingController(text: widget.restaurant.contactEmail ?? '');
    _streetController = TextEditingController(text: widget.restaurant.address.street);
    _cityController = TextEditingController(text: widget.restaurant.address.city);
    _postalCodeController = TextEditingController(text: widget.restaurant.address.postalCode ?? '');
    _countryController = TextEditingController(text: widget.restaurant.address.country);

    for (final c in [_nameController, _descriptionController, _phoneController,
        _emailController, _streetController, _cityController,
        _postalCodeController, _countryController]) {
      c.addListener(_markDirty);
    }
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
      _selectedDuration = widget.restaurant.defaultReservationDurationMinutes;
      _initOpeningHours();
      _initSpecialDays();
    }
  }

  void _initSpecialDays() {
    _specialDays = widget.restaurant.specialDays.map((sd) => _SpecialDay(
      date: sd.date,
      isClosed: sd.isClosed,
      openAt: sd.openAt,
      closeAt: sd.closeAt,
      note: sd.note,
    )).toList();
  }

  void _initOpeningHours() {
    _openingHours = List.generate(7, (i) {
      final dayNum = i + 1;
      final existing = widget.restaurant.openingHours
          .where((h) => h.dayOfWeek == dayNum)
          .firstOrNull;
      return _DayHours(
        dayOfWeek: dayNum,
        isClosed: existing?.isClosed ?? true,
        openAt: existing?.openAt?.substring(0, 5) ?? '10:00',
        closeAt: existing?.closeAt?.substring(0, 5) ?? '22:00',
      );
    });
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
    final borderColor = Theme.of(context).dividerColor;
    final sectionShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(color: borderColor),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ExpansionTile(
              controller: _section1Controller,
              leading: const Icon(Icons.restaurant),
              title: const Text('Základní info'),
              initiallyExpanded: true,
              shape: sectionShape,
              collapsedShape: sectionShape,
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: l.nameLabel,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.restaurant),
                  ),
                  validator: (v) => (v == null || v.isEmpty) ? l.nameRequired : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: l.descriptionLabel,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.description),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: l.phoneLabel,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: l.contactEmailLabel,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: _buildSaveButton(l),
                ),
              ],
            ),

            const SizedBox(height: 8),

            ExpansionTile(
              controller: _section2Controller,
              leading: const Icon(Icons.location_on),
              title: const Text('Adresa'),
              shape: sectionShape,
              collapsedShape: sectionShape,
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [
                const SizedBox(height: 8),
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
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: _buildSaveButton(l),
                ),
              ],
            ),

            const SizedBox(height: 8),

            ExpansionTile(
              controller: _section3Controller,
              leading: const Icon(Icons.schedule),
              title: const Text('Otevírací doba'),
              shape: sectionShape,
              collapsedShape: sectionShape,
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [
                const SizedBox(height: 8),
                ..._openingHours.map((day) {
                  final idx = day.dayOfWeek - 1;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 32,
                          child: Checkbox(
                            value: !day.isClosed,
                            activeColor: AppColors.primary,
                            onChanged: (val) => _setStateDirty(() =>
                                _openingHours[idx] = day.copyWith(isClosed: !(val ?? false))),
                          ),
                        ),
                        SizedBox(
                          width: 62,
                          child: Text(
                            _dayNames[idx],
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: day.isClosed ? AppColors.textMuted : AppColors.textPrimary,
                            ),
                          ),
                        ),
                        if (day.isClosed)
                          const Text('Zavřeno', style: TextStyle(fontSize: 12, color: AppColors.textMuted))
                        else ...[
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _timeOptions.contains(day.openAt) ? day.openAt : null,
                              isDense: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              ),
                              style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                              items: _timeOptions.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                              onChanged: (val) {
                                if (val == null) return;
                                _setStateDirty(() =>
                                  _openingHours[idx] = day.copyWith(openAt: val));
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Text('–', style: TextStyle(fontSize: 16)),
                          ),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _timeOptions.contains(day.closeAt) ? day.closeAt : null,
                              isDense: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              ),
                              style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                              items: _timeOptions
                                  .map((t) => DropdownMenuItem(
                                    value: t,
                                    child: Text(
                                      t.compareTo(day.openAt) <= 0
                                          ? '$t (další den)'
                                          : t,
                                    ),
                                  ))
                                  .toList(),
                              onChanged: (val) => _setStateDirty(() =>
                                  _openingHours[idx] = day.copyWith(closeAt: val ?? day.closeAt)),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }),
                const Divider(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Výjimečné dny',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _addSpecialDay,
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Přidat'),
                    ),
                  ],
                ),
                if (_specialDays.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Žádné výjimečné dny nejsou nastaveny.',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                    ),
                  )
                else
                  ..._specialDays.asMap().entries.map((entry) {
                    final i = entry.key;
                    final sd = entry.value;
                    final dateStr = '${sd.date.day}.${sd.date.month}.${sd.date.year}';
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        dense: true,
                        leading: Icon(
                          sd.isClosed ? Icons.block : Icons.schedule,
                          color: sd.isClosed ? AppColors.error : AppColors.primary,
                        ),
                        title: Text(dateStr, style: const TextStyle(fontWeight: FontWeight.w500)),
                        subtitle: Text(
                          sd.isClosed
                              ? 'Zavřeno${sd.note != null ? " — ${sd.note}" : ""}'
                              : '${sd.openAt} – ${sd.closeAt}${sd.note != null ? " — ${sd.note}" : ""}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined, color: AppColors.primary, size: 20),
                              onPressed: () => _editSpecialDay(i),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline, color: AppColors.error, size: 20),
                              onPressed: () => _setStateDirty(() => _specialDays.removeAt(i)),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: _buildSaveButton(l),
                ),
              ],
            ),

            const SizedBox(height: 8),

            ExpansionTile(
              controller: _section4Controller,
              leading: const Icon(Icons.timer),
              title: const Text('Nastavení rezervací'),
              shape: sectionShape,
              collapsedShape: sectionShape,
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [
                const SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  value: _selectedDuration,
                  decoration: const InputDecoration(
                    labelText: 'Výchozí délka rezervace',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.timer),
                  ),
                  items: const [
                    DropdownMenuItem(value: 30, child: Text('30 min')),
                    DropdownMenuItem(value: 45, child: Text('45 min')),
                    DropdownMenuItem(value: 60, child: Text('1 hod')),
                    DropdownMenuItem(value: 90, child: Text('1,5 hod')),
                    DropdownMenuItem(value: 120, child: Text('2 hod')),
                    DropdownMenuItem(value: 150, child: Text('2,5 hod')),
                    DropdownMenuItem(value: 180, child: Text('3 hod')),
                  ],
                  onChanged: (val) => _setStateDirty(() => _selectedDuration = val ?? 60),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: _buildSaveButton(l),
                ),
              ],
            ),

            if (widget.isOwner) ...[
              const SizedBox(height: 8),
              ExpansionTile(
                leading: const Icon(Icons.panorama),
                title: const Text('Panorama'),
                shape: sectionShape,
                collapsedShape: sectionShape,
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                children: [
                  const SizedBox(height: 8),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.panorama,
                        color: widget.panoramaUrl != null ? AppColors.success : AppColors.textMuted,
                      ),
                      title: Text(widget.panoramaUrl != null
                          ? S.of(context).activePanoramaInfo
                          : S.of(context).noPanoramaInfo),
                      trailing: FilledButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => Scaffold(
                                appBar: AppBar(title: Text(S.of(context).panorama)),
                                body: PanoramaTab(activePanoramaUrl: widget.panoramaUrl),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.settings),
                        label: Text(S.of(context).managePanorama),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton(S l) {
    return FilledButton.icon(
      onPressed: widget.isUpdating ? null : _submit,
      icon: widget.isUpdating
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            )
          : const Icon(Icons.save),
      label: Text(widget.isUpdating ? l.savingLabel : l.saveChanges),
    );
  }

  void _setStateDirty(VoidCallback fn) {
    setState(fn);
    _markDirty();
  }

  void _collapseAll() {
    try { _section1Controller.collapse(); } catch (_) {}
    try { _section2Controller.collapse(); } catch (_) {}
    try { _section3Controller.collapse(); } catch (_) {}
    try { _section4Controller.collapse(); } catch (_) {}
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _collapseAll();
      _markClean();
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
          defaultReservationDurationMinutes: _selectedDuration,
          openingHours: _openingHours.map((d) => {
            'dayOfWeek': _javaDay(d.dayOfWeek),
            'openAt': d.isClosed ? null : d.openAt,
            'closeAt': d.isClosed ? null : d.closeAt,
            'closed': d.isClosed,
          }).toList(),
          specialDays: _specialDays.map((sd) => {
            'date': '${sd.date.year}-${sd.date.month.toString().padLeft(2, '0')}-${sd.date.day.toString().padLeft(2, '0')}',
            'closed': sd.isClosed,
            if (sd.openAt != null) 'openAt': sd.openAt,
            if (sd.closeAt != null) 'closeAt': sd.closeAt,
            if (sd.note != null) 'note': sd.note,
          }).toList(),
        ),
      );
    }
  }

  void _editSpecialDay(int index) async {
    final existing = _specialDays[index];
    final result = await _showSpecialDayDialog(
      initialDate: existing.date,
      initialIsClosed: existing.isClosed,
      initialOpenAt: existing.openAt ?? '10:00',
      initialCloseAt: existing.closeAt ?? '14:00',
      initialNote: existing.note,
      isEdit: true,
    );
    if (result != null) {
      _setStateDirty(() {
        _specialDays[index] = result;
        _specialDays.sort((a, b) => a.date.compareTo(b.date));
      });
    }
  }

  void _addSpecialDay() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      locale: const Locale('cs', 'CZ'),
    );
    if (picked == null) return;
    if (_specialDays.any((sd) => sd.date == picked)) return;
    if (!mounted) return;

    final result = await _showSpecialDayDialog(initialDate: picked);
    if (result != null) {
      _setStateDirty(() {
        _specialDays.add(result);
        _specialDays.sort((a, b) => a.date.compareTo(b.date));
      });
    }
  }

  Future<_SpecialDay?> _showSpecialDayDialog({
    required DateTime initialDate,
    bool initialIsClosed = true,
    String initialOpenAt = '10:00',
    String initialCloseAt = '14:00',
    String? initialNote,
    bool isEdit = false,
  }) async {
    bool isClosed = initialIsClosed;
    String openAt = initialOpenAt;
    String closeAt = initialCloseAt;
    String? note = initialNote;
    final noteController = TextEditingController(text: initialNote ?? '');

    return showDialog<_SpecialDay>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlg) => AlertDialog(
          title: Row(
            children: [
              Expanded(child: Text('${initialDate.day}.${initialDate.month}.${initialDate.year}')),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(ctx),
              ),
            ],
          ),
          titlePadding: const EdgeInsets.fromLTRB(24, 16, 8, 0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: const Text('Celý den zavřeno'),
                value: isClosed,
                activeColor: AppColors.primary,
                onChanged: (val) => setDlg(() => isClosed = val),
              ),
              if (!isClosed) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: openAt,
                        isDense: true,
                        decoration: const InputDecoration(
                          labelText: 'Od',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        ),
                        items: _timeOptions.map((t) => DropdownMenuItem(value: t, child: Text(t, style: const TextStyle(fontSize: 13)))).toList(),
                        onChanged: (val) => setDlg(() => openAt = val ?? openAt),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text('–'),
                    ),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: closeAt,
                        isDense: true,
                        decoration: const InputDecoration(
                          labelText: 'Do',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        ),
                        items: _timeOptions.map((t) => DropdownMenuItem(value: t, child: Text(t, style: const TextStyle(fontSize: 13)))).toList(),
                        onChanged: (val) => setDlg(() => closeAt = val ?? closeAt),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 12),
              TextField(
                controller: noteController,
                decoration: const InputDecoration(
                  labelText: 'Poznámka (volitelné)',
                  border: OutlineInputBorder(),
                  hintText: 'např. Státní svátek',
                ),
                onChanged: (val) => note = val.trim().isEmpty ? null : val.trim(),
              ),
            ],
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(ctx, _SpecialDay(
                date: initialDate,
                isClosed: isClosed,
                openAt: isClosed ? null : openAt,
                closeAt: isClosed ? null : closeAt,
                note: note,
              )),
              child: Text(isEdit ? 'Uložit' : 'Přidat'),
            ),
          ],
        ),
      ),
    );
  }

  String _javaDay(int day) => const [
    'MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY','SATURDAY','SUNDAY'
  ][day - 1];
}

/// Mutable view-model for a single weekday's operating hours within the form.
class _DayHours {
  final int dayOfWeek;
  final bool isClosed;
  final String openAt;
  final String closeAt;

  const _DayHours({
    required this.dayOfWeek,
    required this.isClosed,
    required this.openAt,
    required this.closeAt,
  });

  _DayHours copyWith({
    int? dayOfWeek,
    bool? isClosed,
    String? openAt,
    String? closeAt,
  }) => _DayHours(
    dayOfWeek: dayOfWeek ?? this.dayOfWeek,
    isClosed: isClosed ?? this.isClosed,
    openAt: openAt ?? this.openAt,
    closeAt: closeAt ?? this.closeAt,
  );
}

/// Mutable view-model for a single special operating day (holiday, shortened hours, or closure).
class _SpecialDay {
  final DateTime date;
  final bool isClosed;
  final String? openAt;
  final String? closeAt;
  final String? note;

  const _SpecialDay({
    required this.date,
    this.isClosed = true,
    this.openAt,
    this.closeAt,
    this.note,
  });
}
