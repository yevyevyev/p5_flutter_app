import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p5_flutter_app/code_editor.dart';
import 'package:p5_flutter_app/screen/screen.dart';
import 'package:p5_flutter_app/widgets/widgets.dart';

class AppRouter {
  AppRouter() {
    router = GoRouter(
      initialLocation: '/project',
      redirect: (context, state) {
        if (state.uri.toString() == '/') {
          return '/project';
        }

        return null;
      },
      routes: [
        GoRoute(
          path: '/editor',
          builder: (context, state) => CodeEditorWidget(
            initialCode: state.extra as String,
          ),
          parentNavigatorKey: rootNavigator,
        ),
        GoRoute(
          path: '/video',
          builder: (context, state) => VideoPreviewScreen(
            filepath: state.uri.queryParameters['filepath']!,
          ),
          parentNavigatorKey: rootNavigator,
        ),
        GoRoute(
          path: '/preview',
          builder: (context, state) => P5PreviewScreen(
            code: state.extra as String,
            folder: state.uri.queryParameters['folder'] ?? '',
          ),
          parentNavigatorKey: rootNavigator,
        ),
        StatefulShellRoute.indexedStack(
          pageBuilder: (context, state, navigationShell) => NoTransitionPage(
            child: HomeScaffold(navigationShell: navigationShell),
          ),
          branches: [
            StatefulShellBranch(
              navigatorKey: _shellNavigatorProject,
              routes: [
                GoRoute(
                  path: '/project',
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: const ProjectScreen(),
                    key: state.pageKey,
                  ),
                  routes: [
                    GoRoute(
                      path: ':projectId',
                      builder: (context, state) => ProjectDetailsScreen(
                        projectId:
                            int.parse(state.pathParameters['projectId']!),
                      ),
                      routes: [
                        GoRoute(
                          path: 'editor',
                          builder: (context, state) => ProjectCodeEditorScreen(
                            filepath: state.uri.queryParameters['filepath']!,
                            projectId:
                                int.parse(state.pathParameters['projectId']!),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorExamples,
              routes: [
                GoRoute(
                  path: '/examples',
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: const ExampleScreen(),
                    key: state.pageKey,
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorReference,
              routes: [
                GoRoute(
                  path: '/reference',
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: const ReferenceScreen(),
                    key: state.pageKey,
                  ),
                  routes: [
                    GoRoute(
                      path: 'details',
                      builder: (context, state) => ReferenceDetailsScreen(
                        href: state.uri.queryParameters['href']!,
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
          parentNavigatorKey: rootNavigator,
        ),
      ],
      debugLogDiagnostics: kDebugMode,
      navigatorKey: rootNavigator,
    );
  }

  late final GoRouter router;
  static final rootNavigator = GlobalKey<NavigatorState>();
  static final _shellNavigatorProject = GlobalKey<NavigatorState>();
  static final _shellNavigatorExamples = GlobalKey<NavigatorState>();
  static final _shellNavigatorReference = GlobalKey<NavigatorState>();
}
