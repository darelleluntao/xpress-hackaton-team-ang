import 'package:flutter/material.dart';
import 'package:core/src/data/models/service_provider_model.dart';

class RatingSection extends StatelessWidget {
  final ServiceProviderModel serviceProvider;

  const RatingSection({
    super.key,
    required this.serviceProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ratings & Reviews',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            // Overall rating
            Column(
              children: [
                Text(
                  serviceProvider.rating.toString(),
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      size: 16,
                      color: index < serviceProvider.rating.floor()
                          ? Colors.amber
                          : Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${serviceProvider.reviews} reviews',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ],
            ),
            const SizedBox(width: 24),
            // Rating distribution
            Expanded(
              child: Column(
                children: [
                  _buildRatingBar(context, 5, 0.8),
                  _buildRatingBar(context, 4, 0.1),
                  _buildRatingBar(context, 3, 0.05),
                  _buildRatingBar(context, 2, 0.03),
                  _buildRatingBar(context, 1, 0.02),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Recent reviews
        if (serviceProvider.reviewsList.isNotEmpty) ...[
          const Divider(),
          const SizedBox(height: 16),
          ...serviceProvider.reviewsList.take(3).map((review) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(review.userImage),
                        radius: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review.userName,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              review.date.toString(),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            review.rating.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    review.comment,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          }),
        ],
      ],
    );
  }

  Widget _buildRatingBar(BuildContext context, int stars, double percentage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            '$stars',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.star,
            size: 16,
            color: Colors.amber,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${(percentage * 100).toInt()}%',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
          ),
        ],
      ),
    );
  }
} 