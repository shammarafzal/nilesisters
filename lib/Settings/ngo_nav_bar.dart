import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nilesisters/Settings/ngo_ui.dart';
import 'package:nilesisters/utils/navigation_controller.dart';

class NgoBottomNavBar extends StatelessWidget {
  const NgoBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController(), permanent: true);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: NgoPalette.navy.withValues(alpha: 0.12),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        child: Obx(() {
          final selectedIndex = controller.selectedIndex > 4 ? 0 : controller.selectedIndex;
          
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _NavBarItem(
                icon: Icons.grid_view_rounded,
                activeIcon: Icons.grid_view_rounded,
                label: 'Home',
                isSelected: selectedIndex == 0,
                onTap: () => controller.changeIndex(0),
              ),
              _NavBarItem(
                icon: Icons.chat_bubble_outline_rounded,
                activeIcon: Icons.chat_bubble_rounded,
                label: 'Feed',
                isSelected: selectedIndex == 1,
                onTap: () => controller.changeIndex(1),
              ),
              _NavBarItem(
                icon: Icons.auto_awesome_motion_rounded,
                activeIcon: Icons.auto_awesome_motion_rounded,
                label: 'Media',
                isSelected: selectedIndex == 2,
                onTap: () => controller.changeIndex(2),
              ),
              _NavBarItem(
                icon: Icons.calendar_today_rounded,
                activeIcon: Icons.calendar_month_rounded,
                label: 'Events',
                isSelected: selectedIndex == 3,
                onTap: () => controller.changeIndex(3),
              ),
              _NavBarItem(
                icon: Icons.explore_outlined,
                activeIcon: Icons.explore_rounded,
                label: 'Map',
                isSelected: selectedIndex == 4,
                onTap: () => controller.changeIndex(4),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? NgoPalette.primary.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? NgoPalette.primary : NgoPalette.muted,
              size: 26,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                color: isSelected ? NgoPalette.primary : NgoPalette.muted,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
