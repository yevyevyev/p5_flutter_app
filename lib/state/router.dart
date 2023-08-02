import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p5_flutter_app/code_editor.dart';
import 'package:p5_flutter_app/p5_view.dart';
import 'package:p5_flutter_app/screen/screen.dart';
import 'package:p5_flutter_app/widgets/widgets.dart';

class AppRouter {
  AppRouter() {
    router = GoRouter(
      initialLocation: BarItem.project.routeName,
      routes: [
        GoRoute(
          path: '/editor',
          builder: (context, state) => CodeEditorWidget(
            initialCode: state.extra as String,
          ),
          parentNavigatorKey: rootNavigator,
        ),
        GoRoute(
          path: '/preview',
          builder: (context, state) => P5View(code: state.extra as String),
          parentNavigatorKey: rootNavigator,
        ),
        ShellRoute(
          pageBuilder: (context, state, child) => NoTransitionPage(
            child: HomeScaffold(body: child),
          ),
          routes: [
            GoRoute(
              path: BarItem.project.routeName,
              parentNavigatorKey: _shellNavigator,
              pageBuilder: (context, state) => NoTransitionPage(
                child: const ProjectScreen(),
                key: state.pageKey,
              ),
            ),
            GoRoute(
              path: BarItem.example.routeName,
              parentNavigatorKey: _shellNavigator,
              pageBuilder: (context, state) => NoTransitionPage(
                child: const ExampleScreen(),
                key: state.pageKey,
              ),
            ),
            GoRoute(
              path: BarItem.reference.routeName,
              parentNavigatorKey: _shellNavigator,
              pageBuilder: (context, state) => NoTransitionPage(
                child: const ReferenceScreen(),
                key: state.pageKey,
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) => ReferenceDetailsScreen(
                    href: state.extra as String,
                  ),
                )
              ],
            ),
          ],
          parentNavigatorKey: rootNavigator,
          navigatorKey: _shellNavigator,
        ),
      ],
      debugLogDiagnostics: kDebugMode,
      navigatorKey: rootNavigator,
    );
  }

  late final GoRouter router;
  static final rootNavigator = GlobalKey<NavigatorState>();
  static final _shellNavigator = GlobalKey<NavigatorState>();
}
