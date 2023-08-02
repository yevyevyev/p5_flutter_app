import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p5_flutter_app/model/reference.dart';
import 'package:p5_flutter_app/state/state.dart';
import 'package:p5_flutter_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ReferenceDetailsNotifier extends ChangeNotifier {
  ReferenceDetailsNotifier(this.referenceRepository, this.href) {
    token = referenceRepository.getTokenByHref(href)!;
  }

  final ReferenceRepository referenceRepository;
  final String href;
  late final ReferenceTokenModel token;
}

class ReferenceDetailsScreen extends StatelessWidget {
  const ReferenceDetailsScreen({super.key, required this.href});

  final String href;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReferenceDetailsNotifier(context.read(), href),
      builder: (context, child) {
        final notifier = context.watch<ReferenceDetailsNotifier>();
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: SafeArea(
              child: ListTile(
                leading: const BackButton(),
                title: Text(
                  notifier.token.label,
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
              ReferenceDescription(label: notifier.token.description),
              const SizedBox(height: 8),
              if (notifier.token.examples.isNotEmpty) ...[
                const Text(
                  'Examples',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(height: 8),
                ...notifier.token.examples
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
                                onPressed: () =>
                                    context.push('/editor', extra: e),
                                child: const Text('Edit'),
                              ),
                            ),
                          ],
                        ))
                    .toList(),
              ],
              if (notifier.token.syntax.isNotEmpty) ...[
                const Text(
                  'Syntax',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(height: 8),
                ...notifier.token.syntax
                    .map((e) => CodeSnippet(code: e))
                    .toList(),
              ],
              if (notifier.token.parameters.isNotEmpty) ...[
                const SizedBox(height: 8),
                const Text(
                  'Parameters',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(height: 8),
                ...notifier.token.parameters
                    .map(
                      (e) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.paramName,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text('${e.paramType}: ${e.paramDescription}'),
                          const SizedBox(height: 8),
                        ],
                      ),
                    )
                    .toList()
              ],
              if (notifier.token.returns != null) ...[
                const Text(
                  'Returns',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(height: 8),
                Text(notifier.token.returns!),
              ]
            ],
          ),
        );
      },
    );
  }
}
