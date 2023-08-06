import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:p5_flutter_app/app.dart';
import 'package:p5_flutter_app/model/project.dart';
import 'package:p5_flutter_app/state/state.dart';
import 'package:p5_flutter_app/widgets/p5_view/p5_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await P5ViewController.preload();
  await Hive.initFlutter();
  Hive.registerAdapter(ProjectModelAdapter());
  final referenceRepository = ReferenceRepository();
  final examplesRepository = ExamplesRepository();
  final projectsRepository = ProjectsRepository();
  await referenceRepository.preload();
  await examplesRepository.preload();
  await projectsRepository.preload();

  runApp(
    Provider.value(
      value: projectsRepository,
      child: Provider.value(
        value: referenceRepository,
        child: Provider.value(
          value: examplesRepository,
          child: const P5FlutterApp(),
        ),
      ),
    ),
  );
}
