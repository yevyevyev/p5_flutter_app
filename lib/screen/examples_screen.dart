import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:p5_flutter_app/model/example.dart';
import 'package:p5_flutter_app/state/state.dart';
import 'package:p5_flutter_app/widgets/p5_view/p5_view.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ExampleScreenNotifier extends ChangeNotifier with SearchMixin<ExampleModel> {
  ExampleScreenNotifier(this.examplesRepository) {
    addSearchHandler(examplesRepository.searchByName);
  }

  final ExamplesRepository examplesRepository;
}

final exampleScreenProvider = ChangeNotifierProvider((ref) {
  final examples = ref.watch(examplesRepositoryProvider);
  return ExampleScreenNotifier(examples);
});

class ExampleScreen extends ConsumerWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(exampleScreenProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: CupertinoSearchTextField(
          controller: notifier.searchTextController,
        ),
      ),
      body: buildBody(context, notifier),
    );
  }

  Widget buildBody(BuildContext context, ExampleScreenNotifier notifier) {
    if (notifier.isSearch) {
      return ListView.builder(
        itemCount: notifier.searchResults.length,
        itemBuilder: (context, index) => ExampleListTile(
          key: ValueKey(notifier.searchResults[index].hashCode),
          example: notifier.searchResults[index],
        ),
      );
    }

    return CustomScrollView(
      slivers: notifier.examplesRepository.data.map((e) => ExampleSection(exampleGroup: e)).toList(),
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
              itemBuilder: (context, index) => ExampleListTile(
                example: exampleGroup.examples[index],
              ),
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
                child: P5ExamplePreview(example: example),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  void onTap(BuildContext context) => context.push(
        '/editor',
        extra: example.code,
      );
}

class P5ExamplePreview extends ConsumerStatefulWidget {
  const P5ExamplePreview({super.key, required this.example});

  final ExampleModel example;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _P5ExamplePreviewState();
}

class _P5ExamplePreviewState extends ConsumerState<P5ExamplePreview> {
  late final controller = P5ViewController(code: widget.example.code);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return P5View(
      key: ValueKey(widget.example.name.hashCode),
      showConsole: false,
      isFullscreen: false,
      p5controller: controller,
    );
  }
}
