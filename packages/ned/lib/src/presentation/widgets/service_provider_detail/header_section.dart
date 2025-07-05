import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:core/src/data/models/service_provider_model.dart';

class HeaderSection extends StatelessWidget {
  final ServiceProviderModel serviceProvider;

  const HeaderSection({
    super.key,
    required this.serviceProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Image carousel
        PageView.builder(
          itemCount: serviceProvider.images.length,
          itemBuilder: (context, index) {
            return Image.network(
              serviceProvider.images[index],
              fit: BoxFit.cover,
            );
          },
        ),
        // Gradient overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
        ),
        // Service provider name
        Positioned(
          left: 16,
          right: 16,
          bottom: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                serviceProvider.name,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.white.withOpacity(0.8),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    serviceProvider.distance,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
} 