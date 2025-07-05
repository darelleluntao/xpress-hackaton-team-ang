import 'package:core/core.dart';
import 'package:get/get.dart';
import 'package:core/src/data/models/service_provider_model.dart';

class ServiceProviderViewModel extends GetxController {
  final RxList<ServiceProviderModel> serviceProviders = <ServiceProviderModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadServiceProviders();
  }

  Future<void> loadServiceProviders() async {
    try {
      isLoading.value = true;
      error.value = '';

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data
      serviceProviders.value = [
        ServiceProviderModel(
          id: '1',
          name: 'Aling Padala',
          image: 'https://images.unsplash.com/photo-1591946614720-90a587da4a36?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          distance: '2.5 km',
          rating: 4.8,
          reviews: 156,
          price: 45.0,
          isDiscount: true,
          isFavorite: false,
          description: 'Professional pet grooming services including bathing, haircuts, nail trimming, and spa treatments for your furry friends.',
          address: '123 Pet Street, City',
          phoneNumber: '+1234567890',
          email: 'contact@pawsomegrooming.com',
          images: [
            'https://images.unsplash.com/photo-1591946614720-90a587da4a36?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
            'https://images.unsplash.com/photo-1583337130417-3346a1be7dee?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
          ],
          services: ['Full Grooming', 'Bath & Brush', 'Nail Trimming', 'Pet Spa'],
          reviewsList: [
            ReviewModel(
              id: '1',
              userId: 'user1',
              userName: 'Sarah Johnson',
              userImage: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
              rating: 5.0,
              comment: 'Amazing service! My dog looks and smells wonderful!',
              date: DateTime.now(),
            ),
          ],
          offers: [
            OfferModel(
              id: '1',
              title: 'Summer Pet Care Special',
              description: '20% off on full grooming services',
              discount: 20.0,
              validUntil: DateTime.now().add(const Duration(days: 30)),
            ),
          ],
          suggestions: [],
          businessHours: BusinessHoursModel(
            monday: '9:00 AM - 6:00 PM',
            tuesday: '9:00 AM - 6:00 PM',
            wednesday: '9:00 AM - 6:00 PM',
            thursday: '9:00 AM - 6:00 PM',
            friday: '9:00 AM - 6:00 PM',
            saturday: '10:00 AM - 4:00 PM',
            sunday: 'Closed',
          ),
          location: LocationModel(
            latitude: 37.7749,
            longitude: -122.4194,
            address: '123 Pet Street, City',
          ),
        ),
        // Add more mock data as needed
      ];
    } catch (e) {
      error.value = 'Failed to load service providers: $e';
    } finally {
      isLoading.value = false;
    }
  }

  ServiceProviderModel? getServiceProviderById(String id) {
    try {
      return serviceProviders.firstWhere((provider) => provider.id == id);
    } catch (e) {
      return null;
    }
  }

  void toggleFavorite(String id) {
    final index = serviceProviders.indexWhere((provider) => provider.id == id);
    if (index != -1) {
      final provider = serviceProviders[index];
      serviceProviders[index] = provider.copyWith(
        isFavorite: !provider.isFavorite.value,
      );
    }
  }
} 