// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p5_flutter_app/model/project.dart';
import 'package:p5_flutter_app/state/localhost_server/mime_type_resolver.dart';
import 'package:p5_flutter_app/state/projects_repository.dart';
import 'package:p5_flutter_app/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProjectDetailsNotifier extends ChangeNotifier {
  ProjectDetailsNotifier(this.projectsRepository, this.projectId) {
    _init();
  }

  void _init() async {
    project = projectsRepository.get(projectId)!;
    isLoading = false;
    await _refreshFileList();
  }

  Future<String?> _getFilename(BuildContext context) => TextFieldDialog.show(
        context,
        title: 'Enter filename',
      );

  void addJsFile(BuildContext context) async {
    final filename = await _getFilename(context);
    if (filename == null) {
      return;
    }

    await project.addFile('${_stripFromFileExtension(filename)}.js');
    await _refreshFileList();
  }

  String _stripFromFileExtension(String filename) {
    final splitted = filename.split('.');
    if (splitted.isNotEmpty) {
      filename = splitted.first;
    }
    return filename;
  }

  Future<void> _refreshFileList() async {
    files = await project.listFiles();
    notifyListeners();
  }

  void addImageFile(BuildContext context) async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    await _addMedia(context, file);
  }

  Future<void> _addMedia(BuildContext context, XFile? file) async {
    if (file == null) {
      return;
    }

    final dir = await project.projectDir;
    final filename = await _getFilename(context);
    if (filename == null) {
      return;
    }

    await file.saveTo(
      '${dir.path}/${_stripFromFileExtension(filename)}.${file.name.split('.').last}',
    );
    await _refreshFileList();
  }

  void addVideoFile(BuildContext context) async {
    final file = await ImagePicker().pickVideo(source: ImageSource.gallery);
    await _addMedia(context, file);
  }

  final int projectId;
  late final ProjectModel project;
  final ProjectsRepository projectsRepository;
  List<FileSystemEntity> files = [];
  var isLoading = true;
}

class ProjectDetailsScreen extends StatelessWidget {
  const ProjectDetailsScreen({super.key, required this.projectId});

  final int projectId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProjectDetailsNotifier(context.read(), projectId),
      builder: (context, child) {
        final notifier = context.watch<ProjectDetailsNotifier>();

        if (notifier.isLoading) {
          return const SizedBox();
        }

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => onFabPressed(context),
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            leading: const BackButton(color: Colors.black),
            backgroundColor: Colors.white,
            centerTitle: false,
            title: Text(
              notifier.project.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
          body: const ProjectDetailsBody(),
        );
      },
    );
  }

  void onFabPressed(BuildContext context) async {
    final notifier = context.read<ProjectDetailsNotifier>();
    final result = await ProjectDetailsAddActionSheet.show(context);
    if (result == null) {
      return;
    }

    switch (result) {
      case ProjectDetailsAddActionSheetResult.file:
        notifier.addJsFile(context);
        return;

      case ProjectDetailsAddActionSheetResult.image:
        notifier.addImageFile(context);
        return;

      case ProjectDetailsAddActionSheetResult.video:
        notifier.addVideoFile(context);
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

  static Future<ProjectDetailsAddActionSheetResult?> show(
          BuildContext context) =>
      showCupertinoModalPopup(
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
          onPressed: () =>
              context.pop(ProjectDetailsAddActionSheetResult.image),
        ),
        CupertinoActionSheetAction(
          child: const Text('Add video'),
          onPressed: () =>
              context.pop(ProjectDetailsAddActionSheetResult.video),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => context.pop(),
        child: const Text('Cancel'),
      ),
    );
  }
}

class ProjectDetailsBody extends StatelessWidget {
  const ProjectDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ProjectDetailsNotifier>();
    return ListView.separated(
      itemBuilder: (context, index) =>
          ProjectDetailsListTile(file: notifier.files[index]),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: notifier.files.length,
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

class ProjectDetailsListTile extends StatelessWidget {
  const ProjectDetailsListTile({
    super.key,
    required this.file,
  });

  final FileSystemEntity file;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(context),
      title: Text(
        filename,
        style: const TextStyle(fontSize: 20),
      ),
      leading: Icon(icon, size: 60),
    );
  }

  String get filename => file.uri.path.split('/').last;

  ProjectDetailsListTileType get tileType =>
      ProjectDetailsListTileTypeX.fromFilename(filename);

  IconData get icon => tileType.toIcon();

  void onTap(BuildContext context) {
    final notifier = context.read<ProjectDetailsNotifier>();
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
        context.push('/project/${notifier.project.key}/editor?filepath=$query');
        return;
      default:
        return;
    }
  }
}
