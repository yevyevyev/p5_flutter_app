import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:p5_flutter_app/app.dart';
import 'package:p5_flutter_app/model/project.dart';
import 'package:p5_flutter_app/state/state.dart';
import 'package:p5_flutter_app/widgets/p5_view/p5_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

Future<Widget> initApp(
  Widget app, {
  bool transientData = false,
}) async {
  await P5ViewController.preload();
  await Hive.initFlutter();

  if (transientData) {
    var appDir = await getApplicationDocumentsDirectory();
    appDir.listSync().map((e) => e.deleteSync()).toList();
  }

  Hive.registerAdapter(ProjectModelAdapter());
  final referenceRepository = ReferenceRepository();
  final examplesRepository = ExamplesRepository();
  final projectsRepository = ProjectsRepository();
  await Future.wait([
    referenceRepository.preload(),
    examplesRepository.preload(),
    projectsRepository.preload(),
  ]);

  return Provider.value(
    value: projectsRepository,
    child: Provider.value(
      value: referenceRepository,
      child: Provider.value(
        value: examplesRepository,
        child: app,
      ),
    ),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = await initApp(const P5FlutterApp());
  runApp(app);
}
