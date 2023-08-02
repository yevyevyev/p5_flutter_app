import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:p5_flutter_app/app.dart';
import 'package:p5_flutter_app/state/state.dart';
import 'package:provider/provider.dart';

void main() async {
  final localhostServer = InAppLocalhostServer(
    documentRoot: 'assets',
    directoryIndex: 'p5.html',
    shared: true,
  );

  WidgetsFlutterBinding.ensureInitialized();
  final referenceRepository = ReferenceRepository();
  final examplesRepository = ExamplesRepository();
  await referenceRepository.preload();
  await examplesRepository.preload();
  await localhostServer.start();

  runApp(
    Provider.value(
      value: referenceRepository,
      child: Provider.value(
        value: localhostServer,
        child: Provider.value(
          value: examplesRepository,
          child: const P5FlutterApp(),
        ),
      ),
    ),
  );
}
