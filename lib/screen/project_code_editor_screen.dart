import 'package:flutter/material.dart';
import 'package:p5_flutter_app/code_editor.dart';
import 'package:p5_flutter_app/model/project.dart';
import 'package:p5_flutter_app/state/state.dart';
import 'package:provider/provider.dart';

class ProjectCodeEditorScreen extends StatelessWidget {
  const ProjectCodeEditorScreen({super.key, required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return CodeEditorWidget(
      initialCode: project.code,
      onChanged: (value) => context
          .read<ProjectsRepository>()
          .updateProject(project..code = value),
    );
  }
}
