import 'package:flutter/material.dart';
import 'package:p5_flutter_app/app.dart';
import 'package:p5_flutter_app/state/localhost_server/spawn_server.dart';
import 'package:p5_flutter_app/state/state.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final referenceRepository = ReferenceRepository();
  final examplesRepository = ExamplesRepository();
  await referenceRepository.preload();
  await examplesRepository.preload();
  await startLocalhost();

  runApp(
    Provider.value(
      value: referenceRepository,
      child: Provider.value(
        value: examplesRepository,
        child: const P5FlutterApp(),
      ),
    ),
  );
}
