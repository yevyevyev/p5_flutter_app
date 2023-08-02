import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:go_router/go_router.dart';

class ReferenceDescription extends StatelessWidget {
  const ReferenceDescription({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      label,
      textStyle: const TextStyle(fontSize: 16),
      baseUrl: Uri.https('p5_flutter.io'),
      onTapUrl: (link) {
        final href = link.split('#');
        context.push('/reference/details', extra: '#${href.last}');
        return true;
      },
    );
  }
}
