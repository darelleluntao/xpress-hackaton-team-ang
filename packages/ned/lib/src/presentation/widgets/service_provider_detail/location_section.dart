import 'package:flutter/material.dart';
import 'package:core/src/data/models/service_provider_model.dart';

class LocationSection extends StatelessWidget {
  final ServiceProviderModel serviceProvider;

  const LocationSection({
    super.key,
    required this.serviceProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        // Address
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.location_on,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceProvider.address,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${serviceProvider.location.latitude}, ${serviceProvider.location.longitude}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Contact information
        Row(
          children: [
            Expanded(
              child: _buildContactItem(
                context,
                Icons.phone,
                'Phone',
                serviceProvider.phoneNumber,
              ),
            ),
            Expanded(
              child: _buildContactItem(
                context,
                Icons.email,
                'Email',
                serviceProvider.email,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Business hours
        Text(
          'Business Hours',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        _buildBusinessHoursRow(context, 'Monday', serviceProvider.businessHours.monday),
        _buildBusinessHoursRow(context, 'Tuesday', serviceProvider.businessHours.tuesday),
        _buildBusinessHoursRow(context, 'Wednesday', serviceProvider.businessHours.wednesday),
        _buildBusinessHoursRow(context, 'Thursday', serviceProvider.businessHours.thursday),
        _buildBusinessHoursRow(context, 'Friday', serviceProvider.businessHours.friday),
        _buildBusinessHoursRow(context, 'Saturday', serviceProvider.businessHours.saturday),
        _buildBusinessHoursRow(context, 'Sunday', serviceProvider.businessHours.sunday),
      ],
    );
  }

  Widget _buildContactItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessHoursRow(BuildContext context, String day, String hours) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              day,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            hours,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
} 