import 'dart:async';
import 'dart:io';

import 'package:async/async.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
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

  Stream<List<ProjectModel>> watchAll() {
    return StreamGroup.merge([
      Stream.value(getAll()),
      _projects.watch().map((event) => getAll()),
    ]);
  }
}

extension ProjectModelX on ProjectModel {
  static final Map<int, StreamController<List<FileSystemEntity>>> _fileStreams = {};

  static StreamController<List<FileSystemEntity>> _getFileStream(int id) => _fileStreams.putIfAbsent(
        id,
        () => StreamController.broadcast(),
      );

  Future<Directory> get projectDir async {
    final appDir = await getApplicationDocumentsDirectory();
    return Directory('${appDir.path}/project_$key');
  }

  void _refreshFileWatcher() => _listFiles().then(_getFileStream(id).add);

  Future<void> addFile(String filename, [String? content]) async {
    final dir = await projectDir;
    final file = await File('${dir.path}/$filename').create(recursive: true);

    if (content != null) {
      await file.writeAsString(content);
    }
    _refreshFileWatcher();
  }

  Future<void> addMedia(XFile file, String filename) async {
    final dir = await projectDir;
    await file.saveTo('${dir.path}/$filename');
    _refreshFileWatcher();
  }

  int get id => int.parse(key.toString());

  Future<List<FileSystemEntity>> _listFiles() async {
    final dir = await projectDir;
    return dir.listSync();
  }

  Stream<List<FileSystemEntity>> watchFiles() => StreamGroup.merge([
        Stream.fromFuture(_listFiles()),
        _getFileStream(id).stream,
      ]);
}
