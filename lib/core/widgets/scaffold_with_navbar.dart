import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_elevation.dart';
import '../theme/colours_dark.dart';

class ScaffoldWithNavbar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const ScaffoldWithNavbar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColoursDark.surface,
        selectedItemColor: ColoursDark.primary,
        unselectedItemColor: ColoursDark.onSurfaceMuted,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        currentIndex: navigationShell.currentIndex,
        onTap: (value) {
          navigationShell.goBranch(
            value,
            initialLocation: value == navigationShell.currentIndex,
          );
        },
        elevation: AppElevation.large,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.chat_bubble_rounded),
            icon: Icon(Icons.chat_bubble_outline_rounded),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.people_alt_rounded),
            icon: Icon(Icons.people_alt_outlined),
            label: 'People',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.search_rounded),
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.settings_rounded),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
