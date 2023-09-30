// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:p5_flutter_app/state/localhost_server/mime_type_resolver.dart';
import 'package:p5_flutter_app/state/state.dart';

class ProjectDetailsScreen extends ConsumerWidget {
  const ProjectDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(currentProjectProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => onFabPressed(context, ref),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          project.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: const ProjectDetailsBody(),
    );
  }

  void onFabPressed(BuildContext context, WidgetRef ref) async {
    final project = ref.read(currentProjectProvider);
    final result = await ProjectDetailsAddActionSheet.show(context);
    if (result == null) {
      return;
    }

    switch (result) {
      case ProjectDetailsAddActionSheetResult.file:
        project.addJsFile(context);
        return;

      case ProjectDetailsAddActionSheetResult.image:
        project.addImageFile(context);
        return;

      case ProjectDetailsAddActionSheetResult.video:
        project.addVideoFile(context);
        return;
    }
  }
}

enum ProjectDetailsAddActionSheetResult {
  file,
  image,
  video,
}

class ProjectDetailsAddActionSheet extends StatelessWidget {
  const ProjectDetailsAddActionSheet({super.key});

  static Future<ProjectDetailsAddActionSheetResult?> show(BuildContext context) => showCupertinoModalPopup(
        context: context,
        builder: (context) => const ProjectDetailsAddActionSheet(),
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          child: const Text('Create new file'),
          onPressed: () => context.pop(ProjectDetailsAddActionSheetResult.file),
        ),
        CupertinoActionSheetAction(
          child: const Text('Add image'),
          onPressed: () => context.pop(ProjectDetailsAddActionSheetResult.image),
        ),
        CupertinoActionSheetAction(
          child: const Text('Add video'),
          onPressed: () => context.pop(ProjectDetailsAddActionSheetResult.video),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => context.pop(),
        child: const Text('Cancel'),
      ),
    );
  }
}

class ProjectDetailsBody extends ConsumerWidget {
  const ProjectDetailsBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final files = ref.watch(currentProjectFilesProvider);
    return files.when(
      data: (data) => ListView.separated(
        itemBuilder: (context, index) => ProjectDetailsListTile(file: data[index]),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: data.length,
      ),
      error: (error, __) => Center(child: Text(error.toString())),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

enum ProjectDetailsListTileType {
  file,
  image,
  video,
  audio,
  font,
  other,
}

extension ProjectDetailsListTileTypeX on ProjectDetailsListTileType {
  static ProjectDetailsListTileType fromFilename(String filename) {
    final mime = MimeTypeResolver.lookup(filename);

    if (mime == null) {
      return ProjectDetailsListTileType.other;
    }

    if (mime.contains('image/')) {
      return ProjectDetailsListTileType.image;
    }

    if (mime.contains('font/')) {
      return ProjectDetailsListTileType.font;
    }

    if (mime == 'application/javascript') {
      return ProjectDetailsListTileType.file;
    }

    if (mime.contains('video/')) {
      return ProjectDetailsListTileType.video;
    }

    if (mime.contains('audio/')) {
      return ProjectDetailsListTileType.audio;
    }

    return ProjectDetailsListTileType.other;
  }

  IconData toIcon() {
    switch (this) {
      case ProjectDetailsListTileType.audio:
        return Icons.music_note;
      case ProjectDetailsListTileType.video:
        return Icons.video_collection_rounded;
      case ProjectDetailsListTileType.image:
        return Icons.photo;
      case ProjectDetailsListTileType.file:
        return Icons.javascript;
      case ProjectDetailsListTileType.font:
        return Icons.font_download;
      case ProjectDetailsListTileType.other:
        return Icons.file_copy;
    }
  }
}

class ProjectDetailsListTile extends ConsumerWidget {
  const ProjectDetailsListTile({
    super.key,
    required this.file,
  });

  final FileSystemEntity file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () => onTap(context, ref),
      title: Text(
        filename,
        style: const TextStyle(fontSize: 20),
      ),
      leading: Icon(icon, size: 60),
    );
  }

  String get filename => file.uri.path.split('/').last;

  ProjectDetailsListTileType get tileType => ProjectDetailsListTileTypeX.fromFilename(filename);

  IconData get icon => tileType.toIcon();

  void onTap(BuildContext context, WidgetRef ref) {
    final projectId = ref.read(currentProjectIdProvider);
    final query = Uri.encodeComponent(file.path);

    switch (tileType) {
      case ProjectDetailsListTileType.image:
        showImageViewer(
          context,
          FileImage(file as File),
          swipeDismissible: true,
          doubleTapZoomable: true,
        );
        return;
      case ProjectDetailsListTileType.video:
        context.push('/video?filepath=$query');
        return;
      case ProjectDetailsListTileType.file:
        context.push('/project/$projectId/editor?filepath=$query');
        return;
      default:
        return;
    }
  }
}
