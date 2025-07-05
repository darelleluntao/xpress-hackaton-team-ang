import 'package:flutter/material.dart';
import 'package:core/src/data/models/service_provider_model.dart';

class DescriptionSection extends StatelessWidget {
  final ServiceProviderModel serviceProvider;

  const DescriptionSection({
    super.key,
    required this.serviceProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Text(
          serviceProvider.description,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        Text(
          'Services',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: serviceProvider.services.map((service) {
            return Chip(
              label: Text(service),
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              labelStyle: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
} 