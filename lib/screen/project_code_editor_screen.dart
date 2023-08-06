import 'dart:io';

import 'package:flutter/material.dart';
import 'package:p5_flutter_app/code_editor.dart';
import 'package:p5_flutter_app/state/state.dart';
import 'package:provider/provider.dart';

class ProjectCodeEditorNotifier extends ChangeNotifier {
  ProjectCodeEditorNotifier({
    required this.projectsRepository,
    required this.projectId,
    required this.filepath,
  }) {
    _init();
  }

  void _init() async {
    try {
      _file = File.fromUri(Uri.file(filepath));
      fileContent = await _file.readAsString();
    } catch (e) {
      error = e;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _fileChangeDebouncer.dispose();
    super.dispose();
  }

  void onContentChanged(String value) => _fileChangeDebouncer.debounce(() {
        _file.writeAsStringSync(value);
      });

  final ProjectsRepository projectsRepository;
  final int projectId;
  final String filepath;
  final _fileChangeDebouncer = Debouncer(const Duration(seconds: 1));

  late File _file;
  late String fileContent;
  Object? error;
  var isLoading = true;
}

class ProjectCodeEditorScreen extends StatelessWidget {
  const ProjectCodeEditorScreen({
    super.key,
    required this.projectId,
    required this.filepath,
  });

  final int projectId;
  final String filepath;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProjectCodeEditorNotifier(
              projectId: projectId,
              projectsRepository: context.read(),
              filepath: filepath,
            ),
        builder: (context, child) {
          final notifier = context.watch<ProjectCodeEditorNotifier>();
          if (notifier.isLoading) {
            return const SizedBox();
          }

          if (notifier.error != null) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: false,
                title: const Text(
                  'Error',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
              body: Center(
                child: Text(
                  'Something went wrong\n${notifier.error!.toString()}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: const BackButton(color: Colors.black),
              elevation: 0,
              centerTitle: false,
              title: Text(
                filename,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ),
            body: CodeEditorWidget(
              initialCode: notifier.fileContent,
              projectFolder: 'project_$projectId/',
              onChanged: notifier.onContentChanged,
            ),
          );
        });
  }

  String get filename => filepath.split('/').last;
}
