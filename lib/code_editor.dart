import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:p5_flutter_app/state/state.dart';
import 'package:p5_flutter_app/widgets/p5_view/p5_view.dart';
import 'package:p5_flutter_app/widgets/p5_view/webview_settings.dart';

const customAutocompleteWords = [
  screenWidthVarName,
  screenHeightVarName,
];

class CodeEditorWidget extends ConsumerStatefulWidget {
  const CodeEditorWidget({
    super.key,
    required this.initialCode,
    this.projectFolder = '',
    this.onChanged,
  });

  final String initialCode;
  final String projectFolder;
  final void Function(String)? onChanged;

  @override
  ConsumerState<CodeEditorWidget> createState() => _CodeEditorWidgetState();
}

class _CodeEditorWidgetState extends ConsumerState<CodeEditorWidget> {
  late final controller = CodeController(
    text: widget.initialCode,
    language: javascript,
  );

  @override
  void initState() {
    final tokens = ref.read(referenceRepositoryProvider).tokens;
    controller.autocompleter.setCustomWords(
      customAutocompleteWords + tokens.map((e) => e.label).toList(),
    );
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
        floatingActionButton: FloatingActionButton(
          onPressed: launchCode,
          child: const Icon(Icons.play_arrow),
        ),
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
                    onChanged: widget.onChanged,
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
            onPressed: launchCode,
            child: Text('RUN'),
          ),
          const Spacer(),
          TextButton(
            onPressed: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Text('HIDE'),
          ),
        ],
      );

  void launchCode() {
    final query = Uri.encodeComponent(widget.projectFolder);
    context.push(
      '/preview?folder=$query',
      extra: controller.fullText,
    );
  }
}
