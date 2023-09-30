import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:p5_flutter_app/state/state.dart';
import 'package:p5_flutter_app/widgets/widgets.dart';

class ReferenceDetailsScreen extends ConsumerWidget {
  const ReferenceDetailsScreen({super.key, required this.href});

  final String href;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(referenceRepositoryProvider).getTokenByHref(href)!;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SafeArea(
          child: ListTile(
            leading: const BackButton(color: Colors.black),
            title: Text(
              token.label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ReferenceDescription(label: token.description),
          const SizedBox(height: 8),
          if (token.examples.isNotEmpty) ...[
            const Text(
              'Examples',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(height: 8),
            ...token.examples
                .map((e) => Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CodeSnippet(code: e),
                              const Divider(),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () => context.push('/editor', extra: e),
                            child: const Text('Edit'),
                          ),
                        ),
                      ],
                    ))
                .toList(),
          ],
          if (token.syntax.isNotEmpty) ...[
            const Text(
              'Syntax',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(height: 8),
            ...token.syntax.map((e) => CodeSnippet(code: e)).toList(),
          ],
          if (token.parameters.isNotEmpty) ...[
            const SizedBox(height: 8),
            const Text(
              'Parameters',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(height: 8),
            ...token.parameters
                .map(
                  (e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e.paramName, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('${e.paramType}: ${e.paramDescription}'),
                      const SizedBox(height: 8),
                    ],
                  ),
                )
                .toList()
          ],
          if (token.returns != null) ...[
            const Text(
              'Returns',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(height: 8),
            Text(token.returns!),
          ]
        ],
      ),
    );
  }
}
