import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/di/injection_container.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../security/config/security_endpoints.dart';
import '../../../../presentation/onboarding/domain/entities/onboarding_menu_category.dart';
import '../../../../presentation/onboarding/domain/entities/onboarding_menu_item.dart';
import '../../../../presentation/onboarding/domain/usecases/get_owner_menu_usecase.dart';
import '../../../../presentation/onboarding/domain/usecases/create_category_usecase.dart';
import '../../../../presentation/onboarding/domain/usecases/update_category_usecase.dart';
import '../../../../presentation/onboarding/domain/usecases/delete_category_usecase.dart';
import '../../../../presentation/onboarding/domain/usecases/create_menu_item_usecase.dart';
import '../../../../presentation/onboarding/domain/usecases/update_menu_item_usecase.dart';
import '../../../../presentation/onboarding/domain/usecases/delete_menu_item_usecase.dart';

/// Záložka pro správu menu restaurace — kategorie a položky s fotkami.
///
/// Umožňuje majiteli vytvářet, upravovat a mazat kategorie i položky,
/// nahrávat a mazat fotky k jednotlivým položkám menu.
class MenuManagementTab extends StatefulWidget {
  final String restaurantId;
  final bool isOwner;

  const MenuManagementTab({
    super.key,
    required this.restaurantId,
    required this.isOwner,
  });

  @override
  State<MenuManagementTab> createState() => _MenuManagementTabState();
}

class _MenuManagementTabState extends State<MenuManagementTab> {
  List<OnboardingMenuCategory> _categories = [];
  bool _loading = false;
  String? _error;

  /// ID položky, jejíž obrázek se právě nahrává.
  String? _uploadingItemId;

  @override
  void initState() {
    super.initState();
    _loadMenu();
  }

  /// Načte menu z backendu a aktualizuje stav.
  Future<void> _loadMenu() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final categories = await sl<GetOwnerMenuUseCase>()();
      if (mounted) {
        setState(() {
          _categories = categories;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
          _error = e.toString();
        });
      }
    }
  }

  // -------------------------------------------------------------------------
  // Kategorie — dialogy
  // -------------------------------------------------------------------------

  /// Dialog pro přidání nové kategorie.
  Future<void> _showAddCategoryDialog() async {
    final nameCtrl = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nová kategorie'),
        content: TextField(
          controller: nameCtrl,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Název kategorie'),
          textCapitalization: TextCapitalization.sentences,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Zrušit'),
          ),
          FilledButton(
            onPressed: () async {
              final name = nameCtrl.text.trim();
              if (name.isEmpty) return;
              Navigator.pop(ctx);
              try {
                await sl<CreateCategoryUseCase>()(
                  name: name,
                  sortOrder: _categories.length,
                );
                _loadMenu();
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Nepodařilo se přidat kategorii: $e'),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
              }
            },
            child: const Text('Přidat'),
          ),
        ],
      ),
    );
    nameCtrl.dispose();
  }

  /// Dialog pro úpravu existující kategorie.
  Future<void> _showEditCategoryDialog(OnboardingMenuCategory category) async {
    final nameCtrl = TextEditingController(text: category.name);
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Upravit kategorii'),
        content: TextField(
          controller: nameCtrl,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Název kategorie'),
          textCapitalization: TextCapitalization.sentences,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Zrušit'),
          ),
          FilledButton(
            onPressed: () async {
              final name = nameCtrl.text.trim();
              if (name.isEmpty) return;
              Navigator.pop(ctx);
              try {
                await sl<UpdateCategoryUseCase>()(
                  category.id,
                  name: name,
                );
                _loadMenu();
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Nepodařilo se upravit kategorii: $e'),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
              }
            },
            child: const Text('Uložit'),
          ),
        ],
      ),
    );
    nameCtrl.dispose();
  }

  /// Dialog pro smazání kategorie s potvrzením.
  Future<void> _showDeleteCategoryDialog(OnboardingMenuCategory category) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Smazat kategorii?'),
        content: Text(
          'Kategorie "${category.name}" a všechny její položky budou trvale smazány.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Zrušit'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Smazat',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    try {
      await sl<DeleteCategoryUseCase>()(category.id);
      _loadMenu();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Nepodařilo se smazat kategorii: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  // -------------------------------------------------------------------------
  // Položky menu — dialogy
  // -------------------------------------------------------------------------

  /// Dialog pro přidání nové položky do kategorie.
  Future<void> _showAddItemDialog(String categoryId) async {
    final nameCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    bool available = true;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlgState) => AlertDialog(
          title: const Text('Nová položka'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Název'),
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: descCtrl,
                  decoration: const InputDecoration(labelText: 'Popis (volitelný)'),
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: priceCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Cena (Kč)',
                    hintText: 'např. 129',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  title: const Text('Dostupná'),
                  value: available,
                  onChanged: (val) => setDlgState(() => available = val),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Zrušit'),
            ),
            FilledButton(
              onPressed: () async {
                final name = nameCtrl.text.trim();
                if (name.isEmpty) return;
                final priceCzk = double.tryParse(
                      priceCtrl.text.trim().replaceAll(',', '.'),
                    ) ??
                    0.0;
                final priceMinor = (priceCzk * 100).round();
                Navigator.pop(ctx);
                try {
                  await sl<CreateMenuItemUseCase>()(
                    categoryId,
                    name: name,
                    description: descCtrl.text.trim().isEmpty
                        ? null
                        : descCtrl.text.trim(),
                    priceMinor: priceMinor,
                    available: available,
                    sortOrder: _categories
                        .firstWhere((c) => c.id == categoryId)
                        .items
                        .length,
                  );
                  _loadMenu();
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Nepodařilo se přidat položku: $e'),
                        backgroundColor: AppColors.error,
                      ),
                    );
                  }
                }
              },
              child: const Text('Přidat'),
            ),
          ],
        ),
      ),
    );
    nameCtrl.dispose();
    descCtrl.dispose();
    priceCtrl.dispose();
  }

  /// Dialog pro úpravu existující položky menu.
  Future<void> _showEditItemDialog(OnboardingMenuItem item) async {
    final nameCtrl = TextEditingController(text: item.name);
    final descCtrl = TextEditingController(text: item.description ?? '');
    final priceCtrl = TextEditingController(
      text: (item.priceMinor / 100).toStringAsFixed(0),
    );
    bool available = item.available;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlgState) => AlertDialog(
          title: const Text('Upravit položku'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Název'),
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: descCtrl,
                  decoration: const InputDecoration(labelText: 'Popis (volitelný)'),
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: priceCtrl,
                  decoration: const InputDecoration(labelText: 'Cena (Kč)'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  title: const Text('Dostupná'),
                  value: available,
                  onChanged: (val) => setDlgState(() => available = val),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Zrušit'),
            ),
            FilledButton(
              onPressed: () async {
                final name = nameCtrl.text.trim();
                if (name.isEmpty) return;
                final priceCzk = double.tryParse(
                      priceCtrl.text.trim().replaceAll(',', '.'),
                    ) ??
                    0.0;
                final priceMinor = (priceCzk * 100).round();
                Navigator.pop(ctx);
                try {
                  await sl<UpdateMenuItemUseCase>()(
                    item.id,
                    name: name,
                    description: descCtrl.text.trim().isEmpty
                        ? null
                        : descCtrl.text.trim(),
                    priceMinor: priceMinor,
                    imageUrl: item.imageUrl,
                    available: available,
                  );
                  _loadMenu();
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Nepodařilo se upravit položku: $e'),
                        backgroundColor: AppColors.error,
                      ),
                    );
                  }
                }
              },
              child: const Text('Uložit'),
            ),
          ],
        ),
      ),
    );
    nameCtrl.dispose();
    descCtrl.dispose();
    priceCtrl.dispose();
  }

  /// Dialog pro smazání položky menu s potvrzením.
  Future<void> _showDeleteItemDialog(OnboardingMenuItem item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Smazat položku?'),
        content: Text('Položka "${item.name}" bude trvale smazána.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Zrušit'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Smazat',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    try {
      await sl<DeleteMenuItemUseCase>()(item.id);
      _loadMenu();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Nepodařilo se smazat položku: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  // -------------------------------------------------------------------------
  // Obrázky položek menu
  // -------------------------------------------------------------------------

  /// Otevře výběr fotek a nahraje obrázek ke konkrétní položce menu.
  Future<void> _uploadItemImage(String itemId) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked == null) return;

    setState(() => _uploadingItemId = itemId);
    try {
      final bytes = await picked.readAsBytes();
      final filename = picked.name.isNotEmpty ? picked.name : 'item.jpg';
      final dio = sl<Dio>();
      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(bytes, filename: filename),
      });
      await dio.post(
        SecurityEndpoints.ownerMenuItemImage(widget.restaurantId, itemId),
        data: formData,
      );
      if (!mounted) return;
      _loadMenu();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Nahrávání selhalo: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _uploadingItemId = null);
    }
  }

  /// Smaže obrázek konkrétní položky menu.
  Future<void> _deleteItemImage(String itemId) async {
    try {
      final dio = sl<Dio>();
      await dio.delete(
        SecurityEndpoints.ownerMenuItemImage(widget.restaurantId, itemId),
      );
      if (!mounted) return;
      _loadMenu();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Mazání obrázku selhalo: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  // -------------------------------------------------------------------------
  // Pomocné metody
  // -------------------------------------------------------------------------

  /// Formátuje cenu z haléřů (priceMinor) na řetězec v Kč.
  String _formatPrice(int priceMinor) {
    if (priceMinor == 0) return 'zdarma';
    final czk = priceMinor / 100;
    if (czk == czk.truncateToDouble()) {
      return '${czk.toInt()} Kč';
    }
    return '${czk.toStringAsFixed(2)} Kč';
  }

  // -------------------------------------------------------------------------
  // Build
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: 8),
            Text(_error!),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _loadMenu,
              child: const Text('Zkusit znovu'),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: _loadMenu,
          child: _categories.isEmpty
              ? ListView(
                  children: [
                    const SizedBox(height: 80),
                    Center(
                      child: Text(
                        'Menu je prázdné.\nPřidejte první kategorii.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textMuted,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return _buildCategoryTile(category);
                  },
                ),
        ),

        // FAB — přidat kategorii
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton.extended(
            onPressed: _showAddCategoryDialog,
            icon: const Icon(Icons.add),
            label: const Text('Přidat kategorii'),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTile(OnboardingMenuCategory category) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        title: Text(
          category.name,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Text(
          '${category.items.length} položek',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textMuted,
              ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 20),
              tooltip: 'Upravit kategorii',
              onPressed: () => _showEditCategoryDialog(category),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, size: 20, color: AppColors.error),
              tooltip: 'Smazat kategorii',
              onPressed: () => _showDeleteCategoryDialog(category),
            ),
          ],
        ),
        children: [
          ...category.items.map((item) => _buildItemTile(item)),
          // Tlačítko přidat položku pod posledním itemem
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: OutlinedButton.icon(
              onPressed: () => _showAddItemDialog(category.id),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Přidat položku'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemTile(OnboardingMenuItem item) {
    final isUploading = _uploadingItemId == item.id;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: SizedBox(
        width: 48,
        height: 48,
        child: isUploading
            ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
            : item.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CachedNetworkImage(
                      imageUrl: item.imageUrl!,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      errorWidget: (ctx, url, err) => const Icon(
                        Icons.fastfood,
                        color: AppColors.textMuted,
                      ),
                    ),
                  )
                : const Icon(Icons.fastfood, color: AppColors.textMuted),
      ),
      title: Text(
        item.name,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.description != null && item.description!.isNotEmpty)
            Text(
              item.description!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textMuted,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          Text(
            '${_formatPrice(item.priceMinor)}${item.available ? '' : ' · nedostupná'}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: item.available ? AppColors.textSecondary : AppColors.textMuted,
                ),
          ),
        ],
      ),
      trailing: PopupMenuButton<String>(
        onSelected: (action) async {
          switch (action) {
            case 'edit':
              await _showEditItemDialog(item);
            case 'upload_image':
              await _uploadItemImage(item.id);
            case 'delete_image':
              await _deleteItemImage(item.id);
            case 'delete':
              await _showDeleteItemDialog(item);
          }
        },
        itemBuilder: (ctx) => [
          const PopupMenuItem(
            value: 'edit',
            child: ListTile(
              leading: Icon(Icons.edit_outlined),
              title: Text('Upravit'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const PopupMenuItem(
            value: 'upload_image',
            child: ListTile(
              leading: Icon(Icons.add_photo_alternate_outlined),
              title: Text('Nahrát obrázek'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          if (item.imageUrl != null)
            const PopupMenuItem(
              value: 'delete_image',
              child: ListTile(
                leading: Icon(Icons.hide_image_outlined),
                title: Text('Smazat obrázek'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          const PopupMenuItem(
            value: 'delete',
            child: ListTile(
              leading: Icon(Icons.delete_outline, color: AppColors.error),
              title: Text(
                'Smazat položku',
                style: TextStyle(color: AppColors.error),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
