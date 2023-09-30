import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p5_flutter_app/code_editor.dart';
import 'package:p5_flutter_app/state/state.dart';

class ProjectCodeEditorScreen extends ConsumerWidget {
  const ProjectCodeEditorScreen({
    super.key,
    required this.filepath,
  });

  final String filepath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: _buildBody(ref),
    );
  }

  Widget _buildBody(WidgetRef ref) {
    final projectId = ref.watch(currentProjectIdProvider);
    return FutureBuilder(
      future: File(filepath).readAsString(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CodeEditorWidget(
            initialCode: snapshot.data!,
            projectFolder: 'project_$projectId/',
            onChanged: (content) {
              File(filepath).writeAsStringSync(content);
            },
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  String get filename => filepath.split('/').last;
}
