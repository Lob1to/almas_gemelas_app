import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/bottom_nav_bar_provider.dart';

class CustomBottomNavBar extends ConsumerWidget {
  final double height;
  final Function(int index) onTap;
  final List<CustomBottomNavItem> items;

  const CustomBottomNavBar({
    super.key,
    required this.height,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedTabProvider);

    return Container(
      width: double.infinity,
      height: height,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      color: Colors.white,
      child: Row(
          children: List.generate(items.length, (index) {
        return Expanded(
          child: CustomBottomNavItem(
            icon: (selectedTab == index)
                ? items[index].activeIcon
                : items[index].icon,
            activeIcon: items[index].activeIcon,
            size: height * 0.8,
            onTap: () {
              onTap(index);
            },
          ),
        );
      })),
    );
  }
}

class CustomBottomNavItem extends StatelessWidget {
  final Widget icon;
  final Widget activeIcon;
  final double size;
  final VoidCallback? onTap;

  const CustomBottomNavItem({
    super.key,
    required this.icon,
    required this.activeIcon,
    this.size = 80 * 0.8,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size,
        height: size,
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
