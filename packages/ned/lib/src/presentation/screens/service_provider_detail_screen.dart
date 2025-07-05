import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:core/core.dart';
import 'package:core/src/data/models/service_provider_model.dart';
import '../widgets/service_provider_detail/header_section.dart';
import '../widgets/service_provider_detail/rating_section.dart';
import '../widgets/service_provider_detail/location_section.dart';
import '../widgets/service_provider_detail/offers_section.dart';
import '../widgets/service_provider_detail/description_section.dart';
import '../widgets/service_provider_detail/suggestions_section.dart';
import '../viewmodels/service_provider_viewmodel.dart';

class ServiceProviderDetailScreen extends StatelessWidget {
  final String id;

  const ServiceProviderDetailScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.find<ServiceProviderViewModel>();
    final serviceProvider = viewModel.getServiceProviderById(id);

    if (serviceProvider == null) {
      return const Scaffold(
        body: Center(
          child: Text('Service provider not found'),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header with image and back button
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: HeaderSection(serviceProvider: serviceProvider),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating section
                  RatingSection(serviceProvider: serviceProvider),
                  const SizedBox(height: 24),
                  // Location section
                  LocationSection(serviceProvider: serviceProvider),
                  const SizedBox(height: 24),
                  // Offers section
                  if (serviceProvider.offers.isNotEmpty)
                    OffersSection(offers: serviceProvider.offers),
                  const SizedBox(height: 24),
                  // Description section
                  DescriptionSection(serviceProvider: serviceProvider),
                  const SizedBox(height: 24),
                  // Suggestions section
                  if (serviceProvider.suggestions.isNotEmpty)
                    SuggestionsSection(suggestions: serviceProvider.suggestions),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement booking functionality
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Book Now'),
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () {
                  viewModel.toggleFavorite(serviceProvider.id);
                },
                icon: Icon(
                  serviceProvider.isFavorite.value
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: serviceProvider.isFavorite.value ? Colors.red : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 