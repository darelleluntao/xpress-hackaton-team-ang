import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A reusable primary button widget that follows the app's design system
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.borderRadius = 12,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? theme.colorScheme.primary,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
        minimumSize: Size(width ?? double.infinity, height ?? 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: isLoading
          ? SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  textColor ?? theme.colorScheme.onPrimary,
                ),
                strokeWidth: 2,
              ),
            )
          : Text(
              text,
              style: theme.textTheme.labelLarge?.copyWith(
                color: textColor ?? theme.colorScheme.onPrimary,
                fontWeight: fontWeight ?? FontWeight.bold,
                fontSize: fontSize ?? 16,
              ),
            ),
    );
  }
}

/// A reusable social login button widget
class SocialLoginButton extends StatelessWidget {
  final String iconPath;
  final String text;
  final VoidCallback onPressed;
  final Color? iconColor;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final double? iconSize;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const SocialLoginButton({
    super.key,
    required this.iconPath,
    required this.text,
    required this.onPressed,
    this.iconColor,
    this.textColor,
    this.borderColor,
    this.width,
    this.height,
    this.iconSize,
    this.fontSize,
    this.fontWeight,
    this.borderRadius = 12,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return OutlinedButton.icon(
      icon: SvgPicture.asset(
        iconPath,
        width: iconSize ?? 24,
        height: iconSize ?? 24,
        colorFilter: ColorFilter.mode(
          iconColor ?? theme.colorScheme.onSurface,
          BlendMode.srcIn,
        ),
      ),
      label: Text(
        text,
        style: theme.textTheme.labelLarge?.copyWith(
          fontWeight: fontWeight ?? FontWeight.w600,
          color: textColor ?? theme.colorScheme.onSurface,
          fontSize: fontSize,
        ),
      ),
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
        minimumSize: Size(width ?? double.infinity, height ?? 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        side: BorderSide(
          color: borderColor ?? theme.colorScheme.onSurface.withOpacity(0.2),
        ),
        foregroundColor: textColor ?? theme.colorScheme.onSurface,
      ),
    );
  }
}

/// A reusable text button widget
class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: textColor ?? theme.colorScheme.primary,
              fontSize: fontSize,
              fontWeight: fontWeight ?? FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
} 