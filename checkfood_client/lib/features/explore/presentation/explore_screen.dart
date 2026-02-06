import 'package:flutter/material.dart';

import '../../../core/theme/spacing.dart';

import '../../../components/layout/section_header.dart';
import '../../../components/inputs/search_field.dart';
import '../../../components/cards/restaurant_card.dart';

import '../domain/restaurant_model.dart';
import 'restaurant_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final bool _isLoading = false;

  final List<Restaurant> _restaurants = const [
    Restaurant(
      id: '1',
      name: 'La Piazza',
      cuisine: 'Italian',
      rating: 4.7,
      distance: '1.2 km',
    ),
    Restaurant(
      id: '2',
      name: 'Sushi Master',
      cuisine: 'Japanese',
      rating: 4.9,
      distance: '2.1 km',
    ),
    Restaurant(
      id: '3',
      name: 'Burger House',
      cuisine: 'American',
      rating: 4.4,
      distance: '0.8 km',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explore'), centerTitle: false),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : CustomScrollView(
                slivers: [
                  /* ---------------------------------------------------------- */
                  /* SEARCH */
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.base),
                      child: Column(
                        children: const [
                          SearchField(),
                          SizedBox(height: AppSpacing.lg),
                        ],
                      ),
                    ),
                  ),

                  /* ---------------------------------------------------------- */
                  /* SECTION HEADER */
                  const SliverToBoxAdapter(
                    child: SectionHeader(title: 'Popular near you'),
                  ),

                  /* ---------------------------------------------------------- */
                  /* RESTAURANT LIST */
                  SliverPadding(
                    padding: const EdgeInsets.all(AppSpacing.base),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final restaurant = _restaurants[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                          child: RestaurantCard(
                            name: restaurant.name,
                            cuisine: restaurant.cuisine,
                            rating: restaurant.rating,
                            distance: restaurant.distance,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (_) => RestaurantDetailScreen(
                                        restaurant: restaurant,
                                      ),
                                ),
                              );
                            },
                          ),
                        );
                      }, childCount: _restaurants.length),
                    ),
                  ),
                ],
              ),
    );
  }
}
