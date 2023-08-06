import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TextFieldDialog extends StatelessWidget {
  const TextFieldDialog({
    super.key,
    required this.title,
  });

  final String title;

  static Future<String?> show(BuildContext context, {required String title}) =>
      showDialog(
        context: context,
        builder: (_) => TextFieldDialog(title: title),
      );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              style: const TextStyle(fontSize: 20),
              textInputAction: TextInputAction.done,
              autofocus: true,
              onSubmitted: (value) => context.pop(value),
            ),
          ],
        ),
      ),
    );
  }
}
