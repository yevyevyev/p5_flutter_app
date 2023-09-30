import 'package:flutter/material.dart';
import 'package:p5_flutter_app/widgets/p5_view/p5_view.dart';
import 'package:p5_flutter_app/widgets/p5_view/p5_view_impl.dart';

class P5PreviewScreen extends StatefulWidget {
  const P5PreviewScreen({
    super.key,
    required this.code,
    required this.folder,
  });

  final String code;
  final String folder;

  @override
  State<P5PreviewScreen> createState() => _P5PreviewScreenState();
}

class _P5PreviewScreenState extends State<P5PreviewScreen> {
  late final controller = P5ViewController(code: widget.code, folder: widget.folder);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: P5View(
        p5controller: controller,
        isFullscreen: true,
      ),
    );
  }
}
