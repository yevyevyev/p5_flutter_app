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
        builder: (context, child) => GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: context
                  .watch<ExampleScreenNotifier>()
                  .examplesRepository
                  .examples
                  .length,
              itemBuilder: (context, index) => ExampleGridCell(
                  example: context
                      .watch<ExampleScreenNotifier>()
                      .examplesRepository
                      .examples[index]),
            )
        // builder: (context, child) => CustomScrollView(
        //   slivers: context
        //       .watch<ExampleScreenNotifier>()
        //       .examplesRepository
        //       .data
        //       .map((e) => ExampleSection(exampleGroup: e))
        //       .toList(),
        // ),
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
            SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: exampleGroup.examples.length,
              itemBuilder: (context, index) =>
                  ExampleGridCell(example: exampleGroup.examples[index]),
            ),
          ],
        );
}

class ExampleGridCell extends StatelessWidget {
  const ExampleGridCell({super.key, required this.example});

  final ExampleModel example;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: Stack(
        children: [
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  example.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ChangeNotifierProvider(
                    create: (context) => P5ViewController(example.code),
                    builder: (context, child) =>
                        P5View(key: ValueKey(example.hashCode)),
                  ),
                ),
              ],
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
