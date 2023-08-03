import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: buildDestinations(),
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }

  List<Widget> buildDestinations() => const [
        NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Project',
        ),
        NavigationDestination(
          icon: Icon(Icons.bookmark),
          label: 'Examples',
        ),
        NavigationDestination(
          icon: Icon(Icons.data_object_outlined),
          label: 'Reference',
        ),
      ];
}
