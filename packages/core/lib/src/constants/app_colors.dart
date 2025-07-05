import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF00B14F); // Main brand color
  static const Color primaryDark = Color(0xFF009943); // Darker shade for hover/pressed states
  static const Color primaryLight = Color(0xFFB8E986); // Lighter shade for backgrounds

  // Secondary Colors
  static const Color secondary = Color(0xFF78909C); // Secondary brand color
  static const Color secondaryDark = Color(0xFF607D8B); // Darker shade
  static const Color secondaryLight = Color(0xFFB0BEC5); // Lighter shade

  // Category Colors (using secondary color palette)
  static const Color categoryGrooming = secondary;
  static const Color categoryVaccination = secondaryDark;
  static const Color categoryCheckup = Color(0xFF546E7A);
  static const Color categoryPetShop = Color(0xFF455A64);
  static const Color categoryTraining = Color(0xFF37474F);
  static const Color categoryBoarding = secondary;
  static const Color categoryDaycare = secondaryDark;
  static const Color categoryEmergency = Color(0xFF546E7A);

  // Category Background Colors (10% opacity)
  static Color categoryGroomingBg = categoryGrooming.withOpacity(0.1);
  static Color categoryVaccinationBg = categoryVaccination.withOpacity(0.1);
  static Color categoryCheckupBg = categoryCheckup.withOpacity(0.1);
  static Color categoryPetShopBg = categoryPetShop.withOpacity(0.1);
  static Color categoryTrainingBg = categoryTraining.withOpacity(0.1);
  static Color categoryBoardingBg = categoryBoarding.withOpacity(0.1);
  static Color categoryDaycareBg = categoryDaycare.withOpacity(0.1);
  static Color categoryEmergencyBg = categoryEmergency.withOpacity(0.1);

  // Surface Colors
  static const Color surface = Color(0xFFF6FFF9); // Light background
  static const Color surfaceDark = Color(0xFFE0E0E0); // Darker background

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFF9E9E9E);

  // Error Colors
  static const Color error = Color(0xFFE63946);
  static const Color errorLight = Color(0xFFFFEBEE);
} 