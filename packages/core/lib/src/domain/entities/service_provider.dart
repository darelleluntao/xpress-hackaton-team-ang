import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_provider.freezed.dart';
part 'service_provider.g.dart';

@freezed
class ServiceProvider with _$ServiceProvider {
  const factory ServiceProvider({
    required String id,
    required String name,
    required String image,
    required String distance,
    required double rating,
    required int reviews,
    required double price,
    @Default(false) bool isDiscount,
    @Default(false) bool isFavorite,
    // New fields for detail screen
    required String description,
    required String address,
    required String phoneNumber,
    required String email,
    required List<String> images,
    required List<String> services,
    required List<Review> reviewsList,
    required List<Offer> offers,
    required List<ServiceProvider> suggestions,
    required BusinessHours businessHours,
    required Location location,
  }) = _ServiceProvider;

  factory ServiceProvider.fromJson(Map<String, dynamic> json) =>
      _$ServiceProviderFromJson(json);
}

@freezed
class Review with _$Review {
  const factory Review({
    required String id,
    required String userId,
    required String userName,
    required String userImage,
    required double rating,
    required String comment,
    required DateTime date,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}

@freezed
class Offer with _$Offer {
  const factory Offer({
    required String id,
    required String title,
    required String description,
    required double discount,
    required DateTime validUntil,
  }) = _Offer;

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);
}

@freezed
class BusinessHours with _$BusinessHours {
  const factory BusinessHours({
    required String monday,
    required String tuesday,
    required String wednesday,
    required String thursday,
    required String friday,
    required String saturday,
    required String sunday,
  }) = _BusinessHours;

  factory BusinessHours.fromJson(Map<String, dynamic> json) =>
      _$BusinessHoursFromJson(json);
}

@freezed
class Location with _$Location {
  const factory Location({
    required double latitude,
    required double longitude,
    required String address,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
} 