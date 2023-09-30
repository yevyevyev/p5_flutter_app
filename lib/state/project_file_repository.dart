// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p5_flutter_app/model/project.dart';
import 'package:p5_flutter_app/state/projects_repository.dart';
import 'package:p5_flutter_app/widgets/text_field_dialog.dart';

extension ProjectFilesRepository on ProjectModel {
  Future<String?> _getFilename(BuildContext context) => TextFieldDialog.show(
        context,
        title: 'Enter filename',
      );

  void addJsFile(BuildContext context) async {
    final filename = await _getFilename(context);
    if (filename == null) {
      return;
    }

    await addFile('${_stripFromFileExtension(filename)}.js');
  }

  void addImageFile(BuildContext context) async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    await _addMedia(context, file);
  }

  Future<void> _addMedia(BuildContext context, XFile? file) async {
    if (file == null) {
      return;
    }

    final filename = await _getFilename(context);
    if (filename == null) {
      return;
    }

    await addMedia(
      file,
      '${_stripFromFileExtension(filename)}.${file.name.split('.').last}',
    );
  }

  void addVideoFile(BuildContext context) async {
    final file = await ImagePicker().pickVideo(source: ImageSource.gallery);
    await _addMedia(context, file);
  }

  String _stripFromFileExtension(String filename) {
    final splitted = filename.split('.');
    if (splitted.isNotEmpty) {
      filename = splitted.first;
    }
    return filename;
  }
}
