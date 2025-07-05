import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:core/src/constants/app_colors.dart';
import 'package:core/src/data/models/service_provider_model.dart';
import '../viewmodels/service_provider_viewmodel.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final String categoryName;
  final Color categoryColor;

  const CategoryDetailsScreen({
    super.key,
    required this.categoryName,
    required this.categoryColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final viewModel = Get.put(ServiceProviderViewModel());

    // Load service providers when the screen is built
    viewModel.loadServiceProviders();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          categoryName,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (viewModel.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.error.value.isNotEmpty) {
          return Center(child: Text(viewModel.error.value));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: viewModel.serviceProviders.length,
          itemBuilder: (context, index) {
            return ServiceProviderCard(
              serviceProvider: viewModel.serviceProviders[index],
              theme: theme,
              onPressed: () {
                GoRouter.of(context).push('/service-provider/${viewModel.serviceProviders[index].id}');
              },
            );
          },
        );
      }),
    );
  }
}

class ServiceProviderCard extends StatelessWidget {
  final ServiceProviderModel serviceProvider;
  final ThemeData theme;
  final VoidCallback onPressed;

  const ServiceProviderCard({
    super.key,
    required this.serviceProvider,
    required this.theme,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.find<ServiceProviderViewModel>();

    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        serviceProvider.image,
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (serviceProvider.isDiscount)
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          width: 56,
                          height: 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColors.primary,
                          ),
                          child: Center(
                            child: Text(
                              '20% OFF',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        serviceProvider.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            serviceProvider.distance,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "|",
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            Icons.star,
                            size: 14,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            serviceProvider.rating.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            "(${serviceProvider.reviews})",
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              "\$${serviceProvider.price}",
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Obx(() => IconButton(
                                icon: Icon(
                                  serviceProvider.isFavorite.value
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: serviceProvider.isFavorite.value
                                      ? AppColors.primary
                                      : AppColors.textSecondary,
                                ),
                                onPressed: () {
                                  viewModel.toggleFavorite(serviceProvider.id);
                                },
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
