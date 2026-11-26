import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme/app_theme.dart';
import '../auth/auth_provider.dart';
import '../home/home_screen.dart';
import '../groups/groups_screen.dart';
import '../play/play_screen.dart';
import '../leaderboard/leaderboard_screen.dart';
import '../profile/profile_screen.dart';

class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  int index = 0;

  static const pages = <Widget>[
    HomeScreen(),
    GroupsScreen(),
    PlayScreen(),
    LeaderboardScreen(),
    ProfileScreen(),
  ];

  static const destinations = <NavigationDestination>[
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home_rounded),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.groups_outlined),
      selectedIcon: Icon(Icons.groups_rounded),
      label: 'Groups',
    ),
    NavigationDestination(
      icon: Icon(Icons.sports_esports_outlined),
      selectedIcon: Icon(Icons.sports_esports_rounded),
      label: 'Play',
    ),
    NavigationDestination(
      icon: Icon(Icons.leaderboard_outlined),
      selectedIcon: Icon(Icons.leaderboard_rounded),
      label: 'Leaderboard',
    ),
    NavigationDestination(
      icon: Icon(Icons.person_outline_rounded),
      selectedIcon: Icon(Icons.person_rounded),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(authProfileProvider);
    if (profile == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go('/auth');
      });
    }

    final wide = MediaQuery.sizeOf(context).width >= 800;
    if (wide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: index,
              onDestinationSelected: (value) => setState(() => index = value),
              labelType: NavigationRailLabelType.all,
              minWidth: 88,
              indicatorColor: AppColors.primary.withValues(alpha: .18),
              leading: const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Icon(Icons.bolt_rounded, color: AppColors.primary),
              ),
              destinations: destinations
                  .map(
                    (item) => NavigationRailDestination(
                      icon: item.icon,
                      selectedIcon: item.selectedIcon,
                      label: Text(item.label),
                    ),
                  )
                  .toList(),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: IndexedStack(index: index, children: pages),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: destinations,
      ),
    );
  }
}
