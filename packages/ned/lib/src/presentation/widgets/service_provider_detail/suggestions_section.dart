import 'package:flutter/material.dart';
import 'package:core/src/data/models/service_provider_model.dart';
import '../service_provider_card.dart';

class SuggestionsSection extends StatelessWidget {
  final List<ServiceProviderModel> suggestions;

  const SuggestionsSection({
    super.key,
    required this.suggestions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You May Also Like',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final suggestion = suggestions[index];
              return SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: ServiceProviderCard(
                    serviceProvider: suggestion,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
} 