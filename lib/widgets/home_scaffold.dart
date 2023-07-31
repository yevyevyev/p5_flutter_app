import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum BarItem {
  project,
  example,
  reference,
}

extension BarItemX on BarItem {
  Widget toNavBarItem() {
    switch (this) {
      case BarItem.project:
        return const NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Project',
        );
      case BarItem.example:
        return const NavigationDestination(
          icon: Icon(Icons.bookmark),
          label: 'Examples',
        );
      case BarItem.reference:
        return const NavigationDestination(
          icon: Icon(Icons.data_object_outlined),
          label: 'Reference',
        );
    }
  }

  String get routeName {
    switch (this) {
      case BarItem.project:
        return '/project';
      case BarItem.example:
        return '/example';
      case BarItem.reference:
        return '/reference';
    }
  }
}

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({
    super.key,
    required this.body,
  });

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: BarItem.values.indexWhere(
          (e) => GoRouterState.of(context).fullPath!.contains(e.routeName),
        ),
        destinations: BarItem.values.map((e) => e.toNavBarItem()).toList(),
        onDestinationSelected: (value) => context.go(
          BarItem.values[value].routeName,
        ),
      ),
    );
  }
}
