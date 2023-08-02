import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:p5_flutter_app/p5_view.dart';

const customAutocompleteWords = [
  screenWidthVarName,
  screenHeightVarName,
  'describe()',
  'describeElement()',
  'textOutput()',
  'gridOutput()',
  'print()',
  'frameCount',
  'deltaTime',
  'focused',
  'cursor()',
  'frameRate()',
  'getTargetFrameRate()',
  'noCursor()',
  'webglVersion',
  'displayWidth',
  'displayHeight',
  'windowWidth',
  'windowHeight',
  'windowResized()',
  'width',
  'height',
  'fullscreen()',
  'pixelDensity()',
  'displayDensity()',
  'getURL()',
  'getURLPath()',
  'getURLParams()',
];

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
  void initState() {
    controller.autocompleter.setCustomWords(customAutocompleteWords);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final codeThemeData = CodeThemeData(styles: githubTheme);
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) => Scaffold(
        backgroundColor: codeThemeData.styles['root']!.backgroundColor,
        body: SafeArea(
          child: CodeTheme(
            data: codeThemeData,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: CodeField(
                    controller: controller,
                    maxLines: null,
                  ),
                ),
                if (isKeyboardVisible)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: buildActionsRow(context),
                  )
              ],
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
          const Spacer(),
          TextButton(
            onPressed: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Text('HIDE'),
          ),
        ],
      );
}
