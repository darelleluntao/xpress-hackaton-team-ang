// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceProviderImpl _$$ServiceProviderImplFromJson(Map json) =>
    _$ServiceProviderImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      distance: json['distance'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviews: (json['reviews'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      isDiscount: json['isDiscount'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
      description: json['description'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      services:
          (json['services'] as List<dynamic>).map((e) => e as String).toList(),
      reviewsList: (json['reviewsList'] as List<dynamic>)
          .map((e) => Review.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      offers: (json['offers'] as List<dynamic>)
          .map((e) => Offer.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      suggestions: (json['suggestions'] as List<dynamic>)
          .map((e) =>
              ServiceProvider.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      businessHours: BusinessHours.fromJson(
          Map<String, dynamic>.from(json['businessHours'] as Map)),
      location:
          Location.fromJson(Map<String, dynamic>.from(json['location'] as Map)),
    );

Map<String, dynamic> _$$ServiceProviderImplToJson(
        _$ServiceProviderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'distance': instance.distance,
      'rating': instance.rating,
      'reviews': instance.reviews,
      'price': instance.price,
      'isDiscount': instance.isDiscount,
      'isFavorite': instance.isFavorite,
      'description': instance.description,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'images': instance.images,
      'services': instance.services,
      'reviewsList': instance.reviewsList.map((e) => e.toJson()).toList(),
      'offers': instance.offers.map((e) => e.toJson()).toList(),
      'suggestions': instance.suggestions.map((e) => e.toJson()).toList(),
      'businessHours': instance.businessHours.toJson(),
      'location': instance.location.toJson(),
    };

_$ReviewImpl _$$ReviewImplFromJson(Map json) => _$ReviewImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userImage: json['userImage'] as String,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'userImage': instance.userImage,
      'rating': instance.rating,
      'comment': instance.comment,
      'date': instance.date.toIso8601String(),
    };

_$OfferImpl _$$OfferImplFromJson(Map json) => _$OfferImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      discount: (json['discount'] as num).toDouble(),
      validUntil: DateTime.parse(json['validUntil'] as String),
    );

Map<String, dynamic> _$$OfferImplToJson(_$OfferImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'discount': instance.discount,
      'validUntil': instance.validUntil.toIso8601String(),
    };

_$BusinessHoursImpl _$$BusinessHoursImplFromJson(Map json) =>
    _$BusinessHoursImpl(
      monday: json['monday'] as String,
      tuesday: json['tuesday'] as String,
      wednesday: json['wednesday'] as String,
      thursday: json['thursday'] as String,
      friday: json['friday'] as String,
      saturday: json['saturday'] as String,
      sunday: json['sunday'] as String,
    );

Map<String, dynamic> _$$BusinessHoursImplToJson(_$BusinessHoursImpl instance) =>
    <String, dynamic>{
      'monday': instance.monday,
      'tuesday': instance.tuesday,
      'wednesday': instance.wednesday,
      'thursday': instance.thursday,
      'friday': instance.friday,
      'saturday': instance.saturday,
      'sunday': instance.sunday,
    };

_$LocationImpl _$$LocationImplFromJson(Map json) => _$LocationImpl(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String,
    );

Map<String, dynamic> _$$LocationImplToJson(_$LocationImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
    };
