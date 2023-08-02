import 'dart:async';

import 'package:hive/hive.dart';
import 'package:p5_flutter_app/model/model.dart';

class ProjectsRepository {
  late Box<ProjectModel> projects;

  Future<void> preload() async {
    projects = await Hive.openBox('projects');
  }

  void addProject(ProjectModel project) async {
    projects.add(project);
  }

  void updateProject(ProjectModel project) {
    projects.put(project.key, project);
  }
}
