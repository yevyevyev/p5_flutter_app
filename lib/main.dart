import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:p5_flutter_app/app.dart';
import 'package:p5_flutter_app/model/project.dart';
import 'package:p5_flutter_app/state/localhost_server/spawn_server.dart';
import 'package:p5_flutter_app/state/state.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProjectModelAdapter());
  final referenceRepository = ReferenceRepository();
  final examplesRepository = ExamplesRepository();
  final projectsRepository = ProjectsRepository();
  await referenceRepository.preload();
  await examplesRepository.preload();
  await projectsRepository.preload();
  final localhostErrorStream = await startLocalhost();

  runApp(
    Provider.value(
      value: localhostErrorStream,
      child: Provider.value(
        value: projectsRepository,
        child: Provider.value(
          value: referenceRepository,
          child: Provider.value(
            value: examplesRepository,
            child: const P5FlutterApp(),
          ),
        ),
      ),
    ),
  );
}
