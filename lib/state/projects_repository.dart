import 'dart:async';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:p5_flutter_app/model/model.dart';
import 'package:path_provider/path_provider.dart';

const startingCode = '''function setup() {
  createCanvas(screenWidth, screenHeight);
}

function draw() {
  background(255, 50, 50);
}''';

class ProjectsRepository {
  late Box<ProjectModel> _projects;

  Future<void> preload() async {
    _projects = await Hive.openBox('projects');
    if (getAll().isEmpty) {
      await _initialSeed();
    }
  }

  Future<void> _initialSeed() async {
    //TODO: add project which demonstrates imports
    // add project which demonstrates image loading
    // final project = await addProject('Multiple files example');
    // project.addFile('filename');
  }

  Future<ProjectModel> addProject(String name) async {
    final key = await _projects.add(
      ProjectModel()
        ..name = name
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now(),
    );
    await _projects.get(key)!.addFile(
          'index.js',
          startingCode,
        );
    return get(key)!;
  }

  void updateProject(ProjectModel project) {
    _projects.put(project.key, project);
  }

  ProjectModel? get(int id) => _projects.get(id);
  List<ProjectModel> getAll() => _projects.values.toList();
}

extension ProjectModelX on ProjectModel {
  Future<Directory> get projectDir async {
    final appDir = await getApplicationDocumentsDirectory();
    return Directory('${appDir.path}/project_$key');
  }

  Future<void> addFile(String filename, [String? content]) async {
    final dir = await projectDir;
    final file = await File('${dir.path}/$filename').create(recursive: true);

    if (content != null) {
      await file.writeAsString(content);
    }
  }

  Future<List<FileSystemEntity>> listFiles() async {
    final dir = await projectDir;
    return dir.listSync();
  }
}
