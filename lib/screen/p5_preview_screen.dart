import 'package:flutter/material.dart';
import 'package:p5_flutter_app/widgets/p5_view/p5_view_controller.dart';
import 'package:p5_flutter_app/widgets/p5_view/p5_view_impl.dart';
import 'package:provider/provider.dart';

class P5PreviewScreen extends StatelessWidget {
  const P5PreviewScreen({
    super.key,
    required this.code,
    required this.folder,
  });

  final String code;
  final String folder;

  @override
  Widget build(BuildContext context) {
    return Provider(
      dispose: (context, value) => value.dispose(),
      create: (context) => P5ViewController(
        code: code,
        folder: folder,
      ),
      lazy: false,
      builder: (context, child) => Scaffold(
        body: P5View(p5controller: context.read()),
      ),
    );
  }
}
