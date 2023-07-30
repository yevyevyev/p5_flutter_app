import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:p5_flutter_app/p5_view.dart';

class CodeEditorWidget extends StatefulWidget {
  const CodeEditorWidget({
    super.key,
    required this.initialCode,
  });

  final String initialCode;

  @override
  State<CodeEditorWidget> createState() => _CodeEditorWidgetState();
}

class _CodeEditorWidgetState extends State<CodeEditorWidget> {
  late final controller = CodeController(
    text: widget.initialCode,
    language: javascript,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final codeThemeData = CodeThemeData(styles: monokaiSublimeTheme);
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) => Scaffold(
        backgroundColor: codeThemeData.styles['root']!.backgroundColor,
        body: SafeArea(
          child: CodeTheme(
            data: codeThemeData,
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height -
                    MediaQuery.viewInsetsOf(context).bottom -
                    MediaQuery.viewPaddingOf(context).top,
                child: Column(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        maxLines: null,
                      ),
                    ),
                    if (isKeyboardVisible) buildActionsRow(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildActionsRow(BuildContext context) => Row(
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => P5View(code: controller.fullText))),
            child: Text('RUN'),
          ),
        ],
      );
}
