import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:p5_flutter_app/model/example.dart';
import 'package:p5_flutter_app/state/state.dart';
import 'package:p5_flutter_app/widgets/p5_view/p5_view.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ExampleScreenNotifier extends ChangeNotifier {
  ExampleScreenNotifier(this.examplesRepository);
  final ExamplesRepository examplesRepository;
}

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExampleScreenNotifier(context.read()),
      builder: (context, child) => CustomScrollView(
        slivers: context
            .watch<ExampleScreenNotifier>()
            .examplesRepository
            .data
            .map((e) => ExampleSection(exampleGroup: e))
            .toList(),
      ),
    );
  }
}

class ExampleSection extends MultiSliver {
  ExampleSection({
    super.key,
    required ExampleGroupModel exampleGroup,
  }) : super(
          pushPinnedChildren: true,
          children: [
            SliverPinnedHeader(
              child: Material(
                elevation: 2,
                color: Colors.white,
                child: SafeArea(
                  child: ListTile(
                    title: Text(
                      exampleGroup.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverList.builder(
              itemCount: exampleGroup.examples.length,
              itemBuilder: (context, index) =>
                  ExampleListTile(example: exampleGroup.examples[index]),
            ),
          ],
        );
}

class ExampleListTile extends StatelessWidget {
  const ExampleListTile({super.key, required this.example});

  final ExampleModel example;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: Stack(
        children: [
          Card(
            child: ListTile(
              title: Text(
                example.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: SizedBox(
                height: 200,
                child: ChangeNotifierProvider(
                  create: (context) => P5ViewController(example.code),
                  builder: (context, child) =>
                      P5View(key: ValueKey(example.hashCode)),
                ),
              ),
            ),
          ),
          Container(color: Colors.transparent),
        ],
      ),
    );
  }

  void onTap(BuildContext context) => context.push(
        '/editor',
        extra: example.code,
      );
}
