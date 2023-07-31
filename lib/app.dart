import 'package:flutter/material.dart';
import 'package:p5_flutter_app/state/router.dart';
import 'package:provider/provider.dart';

class P5FlutterApp extends StatelessWidget {
  const P5FlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AppRouter(),
      child: Builder(
        builder: (context) => MaterialApp.router(
          routerConfig: context.watch<AppRouter>().router,
        ),
      ),
    );
  }
}
