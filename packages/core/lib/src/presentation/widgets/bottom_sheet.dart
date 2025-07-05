import 'package:flutter/material.dart';

/// A reusable bottom sheet widget that follows the app's design system
class CustomBottomSheet extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final bool isDismissible;
  final bool enableDrag;
  final bool isScrollControlled;
  final double? maxHeight;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final BoxShadow? shadow;

  const CustomBottomSheet({
    super.key,
    required this.child,
    this.backgroundColor,
    this.isDismissible = true,
    this.enableDrag = true,
    this.isScrollControlled = true,
    this.maxHeight,
    this.padding,
    this.borderRadius,
    this.shadow,
  });

  /// Shows the bottom sheet with the given context
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    Color? backgroundColor,
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = true,
    double? maxHeight,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    BoxShadow? shadow,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: isScrollControlled,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => CustomBottomSheet(
        child: child,
        backgroundColor: backgroundColor,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        isScrollControlled: isScrollControlled,
        maxHeight: maxHeight,
        padding: padding,
        borderRadius: borderRadius,
        shadow: shadow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final bottomPadding = mediaQuery.padding.bottom;
    final topPadding = mediaQuery.padding.top;

    return Container(
      constraints: BoxConstraints(
        maxHeight: maxHeight ?? (mediaQuery.size.height - topPadding - bottomPadding),
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.scaffoldBackgroundColor,
        borderRadius: borderRadius ?? const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        boxShadow: [
          shadow ?? BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          if (enableDrag) ...[
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 8),
          ],
          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: padding ?? EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: bottomPadding + 20,
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

/// A reusable bottom sheet header widget
class BottomSheetHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final EdgeInsetsGeometry? padding;

  const BottomSheetHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.titleStyle,
    this.subtitleStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: titleStyle ?? theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: subtitleStyle ?? theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// A reusable bottom sheet footer widget
class BottomSheetFooter extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const BottomSheetFooter({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bottomPadding = mediaQuery.padding.bottom;

    return Container(
      padding: padding ?? EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: bottomPadding + 20,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: child,
    );
  }
} 