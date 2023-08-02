import 'package:flutter/material.dart';
import 'package:p5_flutter_app/widgets/p5_view/p5_view_controller.dart';
import 'package:p5_flutter_app/widgets/p5_view/p5_view_impl.dart';
import 'package:provider/provider.dart';

class P5PreviewScreen extends StatelessWidget {
  const P5PreviewScreen({super.key, required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => P5ViewController(code),
      builder: (context, child) => const P5View(),
    );
  }
}
