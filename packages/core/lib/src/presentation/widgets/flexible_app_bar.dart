import 'package:flutter/material.dart';

enum AppBarStyle { primary, transparent, minimal, branded }

class FlexibleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final AppBarStyle style;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final Widget? titleWidget;
  final bool automaticallyImplyLeading;
  final VoidCallback? onLeadingPressed;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;

  const FlexibleAppBar({
    super.key,
    this.title = '',
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.style = AppBarStyle.primary,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.titleWidget,
    this.automaticallyImplyLeading = true,
    this.onLeadingPressed,
    this.flexibleSpace,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Determine colors based on style
    Color bgColor;
    Color fgColor;
    Widget? leadingWidget = leading;

    switch (style) {
      case AppBarStyle.primary:
        bgColor = backgroundColor ?? theme.primaryColor;
        fgColor = foregroundColor ??
            theme.primaryTextTheme.titleLarge?.color ??
            Colors.white;
        break;
      case AppBarStyle.transparent:
        bgColor = backgroundColor ?? Colors.transparent;
        fgColor = foregroundColor ??
            theme.textTheme.titleLarge?.color ??
            Colors.black;
        break;
      case AppBarStyle.minimal:
        bgColor = backgroundColor ?? theme.scaffoldBackgroundColor;
        fgColor = foregroundColor ??
            theme.textTheme.titleLarge?.color ??
            Colors.black;
        break;
      case AppBarStyle.branded:
        bgColor = backgroundColor ?? theme.colorScheme.primary;
        fgColor = foregroundColor ?? theme.colorScheme.onPrimary;
        break;
    }

    // Create default back button if needed
    if (leadingWidget == null && automaticallyImplyLeading) {
      final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
      final bool canPop = parentRoute?.canPop ?? false;

      if (canPop) {
        leadingWidget = IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onLeadingPressed ?? () => Navigator.of(context).pop(),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        );
      }
    }

    return AppBar(
      title: titleWidget ?? Text(title, style: TextStyle(color: fgColor)),
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      actions: actions,
      leading: leadingWidget,
      centerTitle: centerTitle,
      elevation: elevation,
      automaticallyImplyLeading: automaticallyImplyLeading,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(bottom == null
      ? kToolbarHeight
      : kToolbarHeight + bottom!.preferredSize.height);
}
