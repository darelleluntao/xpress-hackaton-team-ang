import 'package:flutter/material.dart';

/// Design tokens for consistent spacing, sizing, and layout across the app.
/// This is the single source of truth for spacing and sizing values.
class DesignTokens {
  /// Spacing constants to be used for padding, margin, and gaps.
  static const spacing = SpacingTokens();

  /// Size constants for components, buttons, inputs, etc.
  static const sizes = SizeTokens();

  /// Radius constants for rounded corners.
  static const radius = RadiusTokens();

  /// Layout constants for common width and height values.
  static const layout = LayoutTokens();

  /// Insets for consistent edge padding.
  static const insets = EdgeInsetsTokens();
}

/// Spacing values for padding, margin, and gaps.
class SpacingTokens {
  const SpacingTokens();

  /// 4 pixels - Tiny spacing
  final double xs = 4.0;

  /// 8 pixels - Small spacing
  final double s = 8.0;

  /// 12 pixels - Medium-small spacing
  final double ms = 12.0;

  /// 16 pixels - Medium spacing (default)
  final double m = 16.0;

  /// 24 pixels - Medium-large spacing
  final double ml = 24.0;

  /// 32 pixels - Large spacing
  final double l = 32.0;

  /// 48 pixels - Extra large spacing
  final double xl = 48.0;

  /// 64 pixels - Double extra large spacing
  final double xxl = 64.0;
}

/// Size values for components, buttons, inputs, etc.
class SizeTokens {
  const SizeTokens();

  /// Icon size values
  final IconSizeTokens icon = const IconSizeTokens();

  /// Button heights
  final ButtonSizeTokens button = const ButtonSizeTokens();

  /// Input field heights
  final InputSizeTokens input = const InputSizeTokens();

  /// Avatar sizes
  final AvatarSizeTokens avatar = const AvatarSizeTokens();
}

/// Icon size values
class IconSizeTokens {
  const IconSizeTokens();

  /// 16 pixels - Small icon
  final double s = 16.0;

  /// 24 pixels - Medium icon (default)
  final double m = 24.0;

  /// 32 pixels - Large icon
  final double l = 32.0;
}

/// Button height values
class ButtonSizeTokens {
  const ButtonSizeTokens();

  /// 32 pixels - Small button height
  final double s = 32.0;

  /// 40 pixels - Medium button height (default)
  final double m = 40.0;

  /// 48 pixels - Large button height
  final double l = 48.0;
}

/// Input field height values
class InputSizeTokens {
  const InputSizeTokens();

  /// 40 pixels - Small input height
  final double s = 40.0;

  /// 48 pixels - Medium input height (default)
  final double m = 48.0;

  /// 56 pixels - Large input height
  final double l = 56.0;
}

/// Avatar size values
class AvatarSizeTokens {
  const AvatarSizeTokens();

  /// 24 pixels - Extra small avatar
  final double xs = 24.0;

  /// 32 pixels - Small avatar
  final double s = 32.0;

  /// 40 pixels - Medium avatar (default)
  final double m = 40.0;

  /// 56 pixels - Large avatar
  final double l = 56.0;

  /// 72 pixels - Extra large avatar
  final double xl = 72.0;
}

/// Border radius values for rounded corners
class RadiusTokens {
  const RadiusTokens();

  /// 4 pixels - Extra small radius
  final double xs = 4.0;

  /// 8 pixels - Small radius
  final double s = 8.0;

  /// 12 pixels - Medium radius
  final double m = 12.0;

  /// 16 pixels - Large radius
  final double l = 16.0;

  /// 24 pixels - Extra large radius
  final double xl = 24.0;

  /// 50% (circle) - Full radius
  BorderRadius get full => BorderRadius.circular(999);

  /// Creates BorderRadius with the small radius (8px)
  BorderRadius get smallBorderRadius => BorderRadius.circular(s);

  /// Creates BorderRadius with the medium radius (12px)
  BorderRadius get mediumBorderRadius => BorderRadius.circular(m);

  /// Creates BorderRadius with the large radius (16px)
  BorderRadius get largeBorderRadius => BorderRadius.circular(l);
}

/// Layout constants for common width and height values
class LayoutTokens {
  const LayoutTokens();

  /// Maximum content width for large screens
  final double maxContentWidth = 1200.0;

  /// Standard app bar height
  final double appBarHeight = 56.0;

  /// Bottom navigation bar height
  final double bottomNavHeight = 64.0;

  /// Standard card width
  final double cardWidth = 320.0;
}

/// EdgeInsets tokens for consistent padding
class EdgeInsetsTokens {
  const EdgeInsetsTokens();

  /// All edges with extra small spacing (4px)
  EdgeInsets get xs => const EdgeInsets.all(4.0);

  /// All edges with small spacing (8px)
  EdgeInsets get s => const EdgeInsets.all(8.0);

  /// All edges with medium spacing (16px) - default
  EdgeInsets get m => const EdgeInsets.all(16.0);

  /// All edges with large spacing (24px)
  EdgeInsets get l => const EdgeInsets.all(24.0);

  /// All edges with extra large spacing (32px)
  EdgeInsets get xl => const EdgeInsets.all(32.0);

  /// Horizontal with small spacing (8px)
  EdgeInsets get horizontalS => const EdgeInsets.symmetric(horizontal: 8.0);

  /// Horizontal with medium spacing (16px)
  EdgeInsets get horizontalM => const EdgeInsets.symmetric(horizontal: 16.0);

  /// Horizontal with large spacing (24px)
  EdgeInsets get horizontalL => const EdgeInsets.symmetric(horizontal: 24.0);

  /// Vertical with small spacing (8px)
  EdgeInsets get verticalS => const EdgeInsets.symmetric(vertical: 8.0);

  /// Vertical with medium spacing (16px)
  EdgeInsets get verticalM => const EdgeInsets.symmetric(vertical: 16.0);

  /// Vertical with large spacing (24px)
  EdgeInsets get verticalL => const EdgeInsets.symmetric(vertical: 24.0);

  /// Standard page padding (horizontal: 16px, vertical: 24px)
  EdgeInsets get page =>
      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0);
}
