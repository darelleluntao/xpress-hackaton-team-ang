import 'package:get/get.dart';
import '../../domain/entities/service_provider.dart';
import 'package:core/src/data/models/service_provider_model.dart';

class ServiceProviderModel {
  final String id;
  final String name;
  final String image;
  final String distance;
  final double rating;
  final int reviews;
  final double price;
  final bool isDiscount;
  final RxBool isFavorite;
  final String description;
  final String address;
  final String phoneNumber;
  final String email;
  final List<String> images;
  final List<String> services;
  final List<ReviewModel> reviewsList;
  final List<OfferModel> offers;
  final List<ServiceProviderModel> suggestions;
  final BusinessHoursModel businessHours;
  final LocationModel location;

  ServiceProviderModel({
    required this.id,
    required this.name,
    required this.image,
    required this.distance,
    required this.rating,
    required this.reviews,
    required this.price,
    this.isDiscount = false,
    bool isFavorite = false,
    required this.description,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.images,
    required this.services,
    required this.reviewsList,
    required this.offers,
    required this.suggestions,
    required this.businessHours,
    required this.location,
  }) : isFavorite = RxBool(isFavorite);

  factory ServiceProviderModel.fromEntity(ServiceProvider entity) {
    return ServiceProviderModel(
      id: entity.id,
      name: entity.name,
      image: entity.image,
      distance: entity.distance,
      rating: entity.rating,
      reviews: entity.reviews,
      price: entity.price,
      isDiscount: entity.isDiscount,
      isFavorite: entity.isFavorite,
      description: entity.description,
      address: entity.address,
      phoneNumber: entity.phoneNumber,
      email: entity.email,
      images: entity.images,
      services: entity.services,
      reviewsList: entity.reviewsList.map((r) => ReviewModel.fromEntity(r)).toList(),
      offers: entity.offers.map((o) => OfferModel.fromEntity(o)).toList(),
      suggestions: entity.suggestions.map((s) => ServiceProviderModel.fromEntity(s)).toList(),
      businessHours: BusinessHoursModel.fromEntity(entity.businessHours),
      location: LocationModel.fromEntity(entity.location),
    );
  }

  ServiceProvider toEntity() {
    return ServiceProvider(
      id: id,
      name: name,
      image: image,
      distance: distance,
      rating: rating,
      reviews: reviews,
      price: price,
      isDiscount: isDiscount,
      isFavorite: isFavorite.value,
      description: description,
      address: address,
      phoneNumber: phoneNumber,
      email: email,
      images: images,
      services: services,
      reviewsList: reviewsList.map((r) => r.toEntity()).toList(),
      offers: offers.map((o) => o.toEntity()).toList(),
      suggestions: suggestions.map((s) => s.toEntity()).toList(),
      businessHours: businessHours.toEntity(),
      location: location.toEntity(),
    );
  }

  ServiceProviderModel copyWith({
    String? id,
    String? name,
    String? image,
    String? distance,
    double? rating,
    int? reviews,
    double? price,
    bool? isDiscount,
    bool? isFavorite,
    String? description,
    String? address,
    String? phoneNumber,
    String? email,
    List<String>? images,
    List<String>? services,
    List<ReviewModel>? reviewsList,
    List<OfferModel>? offers,
    List<ServiceProviderModel>? suggestions,
    BusinessHoursModel? businessHours,
    LocationModel? location,
  }) {
    return ServiceProviderModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      distance: distance ?? this.distance,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      price: price ?? this.price,
      isDiscount: isDiscount ?? this.isDiscount,
      isFavorite: isFavorite ?? this.isFavorite.value,
      description: description ?? this.description,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      images: images ?? this.images,
      services: services ?? this.services,
      reviewsList: reviewsList ?? this.reviewsList,
      offers: offers ?? this.offers,
      suggestions: suggestions ?? this.suggestions,
      businessHours: businessHours ?? this.businessHours,
      location: location ?? this.location,
    );
  }
}

class ReviewModel {
  final String id;
  final String userId;
  final String userName;
  final String userImage;
  final double rating;
  final String comment;
  final DateTime date;

  ReviewModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.rating,
    required this.comment,
    required this.date,
  });

  factory ReviewModel.fromEntity(Review entity) {
    return ReviewModel(
      id: entity.id,
      userId: entity.userId,
      userName: entity.userName,
      userImage: entity.userImage,
      rating: entity.rating,
      comment: entity.comment,
      date: entity.date,
    );
  }

  Review toEntity() {
    return Review(
      id: id,
      userId: userId,
      userName: userName,
      userImage: userImage,
      rating: rating,
      comment: comment,
      date: date,
    );
  }
}

class OfferModel {
  final String id;
  final String title;
  final String description;
  final double discount;
  final DateTime validUntil;

  OfferModel({
    required this.id,
    required this.title,
    required this.description,
    required this.discount,
    required this.validUntil,
  });

  factory OfferModel.fromEntity(Offer entity) {
    return OfferModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      discount: entity.discount,
      validUntil: entity.validUntil,
    );
  }

  Offer toEntity() {
    return Offer(
      id: id,
      title: title,
      description: description,
      discount: discount,
      validUntil: validUntil,
    );
  }
}

class BusinessHoursModel {
  final String monday;
  final String tuesday;
  final String wednesday;
  final String thursday;
  final String friday;
  final String saturday;
  final String sunday;

  BusinessHoursModel({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  factory BusinessHoursModel.fromEntity(BusinessHours entity) {
    return BusinessHoursModel(
      monday: entity.monday,
      tuesday: entity.tuesday,
      wednesday: entity.wednesday,
      thursday: entity.thursday,
      friday: entity.friday,
      saturday: entity.saturday,
      sunday: entity.sunday,
    );
  }

  BusinessHours toEntity() {
    return BusinessHours(
      monday: monday,
      tuesday: tuesday,
      wednesday: wednesday,
      thursday: thursday,
      friday: friday,
      saturday: saturday,
      sunday: sunday,
    );
  }
}

class LocationModel {
  final double latitude;
  final double longitude;
  final String address;

  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory LocationModel.fromEntity(Location entity) {
    return LocationModel(
      latitude: entity.latitude,
      longitude: entity.longitude,
      address: entity.address,
    );
  }

  Location toEntity() {

    if(latitude == 0.0 && longitude == 0.0){
      throw Exception('Latitude and longitude cannot be 0.0');
    }

    return Location(
      latitude: latitude,
      longitude: longitude,
      address: address,
    );
  }
} 