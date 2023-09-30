import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p5_flutter_app/state/state.dart';
import 'package:p5_flutter_app/widgets/p5_view/p5_view_impl.dart';

class P5PreviewScreen extends ConsumerWidget {
  const P5PreviewScreen({
    super.key,
    required this.code,
    required this.folder,
  });

  final String code;
  final String folder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(p5ViewControllerProvider(code));
    controller.folder = folder;
    return Scaffold(
      body: P5View(p5controller: controller),
    );
  }
}
