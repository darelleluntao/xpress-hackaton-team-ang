import 'package:get/get.dart';

class ServiceProvider {
  final String id;
  final String name;
  final String image;
  final String distance;
  final double rating;
  final int reviews;
  final double price;
  final bool isDiscount;
  final RxBool isFavorite;

  ServiceProvider({
    required this.id,
    required this.name,
    required this.image,
    required this.distance,
    required this.rating,
    required this.reviews,
    required this.price,
    this.isDiscount = false,
    bool isFavorite = false,
  }) : isFavorite = RxBool(isFavorite);
} 