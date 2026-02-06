import 'package:flutter/material.dart';

import '../../../core/theme/spacing.dart';
import '../../../components/cards/menu_item_card.dart';
import '../../../components/layout/section_header.dart';

import '../domain/menu_item_model.dart';
import '../domain/restaurant_model.dart';

import 'menu_item_detail_sheet.dart';

class MenuScreen extends StatefulWidget {
  final Restaurant restaurant;

  const MenuScreen({super.key, required this.restaurant});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final Map<String, List<MenuItem>> _menuByCategory;

  @override
  void initState() {
    super.initState();

    _menuByCategory = _mockMenu();
    _tabController = TabController(
      length: _menuByCategory.keys.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = _menuByCategory.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.name),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [for (final category in categories) Tab(text: category)],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [for (final category in categories) _buildCategory(category)],
      ),
    );
  }

  Widget _buildCategory(String category) {
    final items = _menuByCategory[category]!;

    if (items.isEmpty) {
      return const Center(child: Text('No items in this category'));
    }

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.base),
      children: [
        SectionHeader(title: category, subtitle: '${items.length} items'),
        const SizedBox(height: AppSpacing.base),
        for (final item in items)
          MenuItemCard(
            item: item,
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (_) => MenuItemDetailSheet(item: item),
              );
            },
          ),
      ],
    );
  }

  /* -------------------------------------------------------------------------- */
  /* MOCK DATA – ČISTÁ, BEZ RESTAURANT ID */

  Map<String, List<MenuItem>> _mockMenu() {
    return {
      'Starters': const [
        MenuItem(
          id: '1',
          name: 'Bruschetta',
          description: 'Grilled bread with tomatoes and basil',
          price: 6.50,
        ),
        MenuItem(
          id: '2',
          name: 'Garlic Bread',
          description: 'Freshly baked bread with garlic butter',
          price: 5.00,
          isAvailable: false,
        ),
      ],
      'Mains': const [
        MenuItem(
          id: '3',
          name: 'Margherita Pizza',
          description: 'Tomato sauce, mozzarella, fresh basil',
          price: 12.90,
        ),
        MenuItem(
          id: '4',
          name: 'Spaghetti Carbonara',
          description: 'Pancetta, egg yolk, parmesan cheese',
          price: 14.50,
        ),
      ],
      'Drinks': const [
        MenuItem(
          id: '5',
          name: 'Sparkling Water',
          description: '0.75l bottle',
          price: 3.00,
        ),
      ],
    };
  }
}
