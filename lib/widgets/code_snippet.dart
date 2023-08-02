import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';

class CodeSnippet extends StatelessWidget {
  const CodeSnippet({super.key, required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    final theme = Map<String, TextStyle>.from(githubTheme);
    theme['root'] =
        theme['root']!.copyWith(backgroundColor: Colors.transparent);
    return HighlightView(
      code,
      language: 'javascript',
      theme: theme,
    );
  }
}
