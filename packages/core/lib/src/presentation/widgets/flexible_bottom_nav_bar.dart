import 'package:flutter/material.dart';

enum BottomNavStyle {
  standard,
  curved,
  labeled,
  unlabeled,
  floating,
}

class NavItem {
  final String label;
  final IconData icon;
  final IconData? activeIcon;
  final String route;

  const NavItem({
    required this.label,
    required this.icon,
    this.activeIcon,
    required this.route,
  });
}

class FlexibleBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final List<NavItem> items;
  final ValueChanged<int> onTap;
  final BottomNavStyle style;
  final Color? backgroundColor;
  final Color? activeColor;
  final Color? inactiveColor;
  final double elevation;
  final bool showLabels;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;

  const FlexibleBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
    this.style = BottomNavStyle.standard,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor,
    this.elevation = 8.0,
    this.showLabels = true,
    this.showSelectedLabels = true,
    this.showUnselectedLabels = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Configure colors based on theme if not specified
    final Color bgColor = backgroundColor ??
        theme.bottomNavigationBarTheme.backgroundColor ??
        theme.colorScheme.surface;
    final Color actColor = activeColor ??
        theme.bottomNavigationBarTheme.selectedItemColor ??
        theme.colorScheme.primary;
    final Color inactColor = inactiveColor ??
        theme.bottomNavigationBarTheme.unselectedItemColor ??
        theme.colorScheme.onSurface.withOpacity(0.6);

    switch (style) {
      case BottomNavStyle.standard:
      case BottomNavStyle.labeled:
      case BottomNavStyle.unlabeled:
        return BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          backgroundColor: bgColor,
          selectedItemColor: actColor,
          unselectedItemColor: inactColor,
          showSelectedLabels:
              style == BottomNavStyle.unlabeled ? false : showSelectedLabels,
          showUnselectedLabels: style == BottomNavStyle.unlabeled
              ? false
              : (style == BottomNavStyle.labeled ? true : showUnselectedLabels),
          type: BottomNavigationBarType.fixed,
          elevation: elevation,
          items: items
              .map((item) => BottomNavigationBarItem(
                    icon: Icon(item.icon),
                    activeIcon:
                        item.activeIcon != null ? Icon(item.activeIcon) : null,
                    label: item.label,
                    tooltip: item.label,
                  ))
              .toList(),
        );

      case BottomNavStyle.curved:
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            backgroundColor: bgColor,
            selectedItemColor: actColor,
            unselectedItemColor: inactColor,
            showSelectedLabels: showSelectedLabels,
            showUnselectedLabels: showUnselectedLabels,
            type: BottomNavigationBarType.fixed,
            elevation: elevation,
            items: items
                .map((item) => BottomNavigationBarItem(
                      icon: Icon(item.icon),
                      activeIcon: item.activeIcon != null
                          ? Icon(item.activeIcon)
                          : null,
                      label: item.label,
                      tooltip: item.label,
                    ))
                .toList(),
          ),
        );

      case BottomNavStyle.floating:
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: onTap,
                backgroundColor: bgColor,
                selectedItemColor: actColor,
                unselectedItemColor: inactColor,
                showSelectedLabels: showSelectedLabels,
                showUnselectedLabels: showUnselectedLabels,
                type: BottomNavigationBarType.fixed,
                elevation: 0, // No elevation as we're using container shadow
                items: items
                    .map((item) => BottomNavigationBarItem(
                          icon: Icon(item.icon),
                          activeIcon: item.activeIcon != null
                              ? Icon(item.activeIcon)
                              : null,
                          label: item.label,
                          tooltip: item.label,
                        ))
                    .toList(),
              ),
            ),
          ),
        );
    }
  }
}
