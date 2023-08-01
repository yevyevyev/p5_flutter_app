import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:p5_flutter_app/model/example.dart';
import 'package:p5_flutter_app/p5_view.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  List<ExampleGroupModel> exampleGroups = [];

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() async {
    final file = await rootBundle.loadString('assets/p5_examples.json');
    final json = jsonDecode(file) as List;
    exampleGroups = json.map((e) => ExampleGroupModel.fromJson(e)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (exampleGroups.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return CustomScrollView(
      slivers:
          exampleGroups.map((e) => ExampleSection(exampleGroup: e)).toList(),
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
              child: Container(
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    ExampleListTile(example: exampleGroup.examples[index]),
                childCount: exampleGroup.examples.length,
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
    return Card(
      child: ListTile(
        title: Text(
          example.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: () => onTap(context),
        subtitle: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onTap(context),
          child: SizedBox(
            height: 200,
            width: double.infinity,
            child: P5View(code: example.code),
          ),
        ),
      ),
    );
  }

  void onTap(BuildContext context) => context.push(
        '/editor',
        extra: example.code,
      );
}
