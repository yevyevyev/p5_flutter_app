import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p5_flutter_app/model/reference.dart';
import 'package:p5_flutter_app/state/state.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ReferenceScreenNotifier extends ChangeNotifier
    with SearchMixin<ReferenceTokenModel> {
  ReferenceScreenNotifier(this.referenceRepository) {
    addSearchHandler(referenceRepository.searchTokens);
  }

  final ReferenceRepository referenceRepository;
}

class ReferenceScreen extends StatelessWidget {
  const ReferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReferenceScreenNotifier(context.read()),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: CupertinoSearchTextField(
            controller:
                context.read<ReferenceScreenNotifier>().searchTextController,
          ),
        ),
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    final notifier = context.watch<ReferenceScreenNotifier>();
    if (notifier.isSearch) {
      return ListView.builder(
        itemCount: notifier.searchResults.length,
        itemBuilder: (context, index) => ReferenceTokenListTile(
          token: notifier.searchResults[index],
        ),
      );
    }

    return CustomScrollView(
      slivers: notifier.referenceRepository.data
          .map((e) => ReferenceSection(referenceGroup: e))
          .toList(),
    );
  }
}

class ReferenceSection extends StatelessWidget {
  const ReferenceSection({
    super.key,
    required this.referenceGroup,
  });

  final ReferenceGroupModel referenceGroup;

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      pushPinnedChildren: true,
      children: [
        SliverPinnedHeader(
          child: Material(
            elevation: 2,
            color: Colors.white,
            child: SafeArea(
              child: ListTile(
                title: Text(
                  referenceGroup.groupName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        ...referenceGroup.subgroups
            .expand(
              (e) => [
                SliverList.builder(
                  itemCount: e.tokens.length,
                  itemBuilder: (context, index) => ReferenceTokenListTile(
                    token: e.tokens[index],
                  ),
                )
              ],
            )
            .toList(),
      ],
    );
  }
}

class ReferenceTokenListTile extends StatelessWidget {
  const ReferenceTokenListTile({super.key, required this.token});

  final ReferenceTokenModel token;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          token.label,
          style: const TextStyle(
            color: Colors.blue,
          ),
        ),
        onTap: () => onTap(context),
      ),
    );
  }

  void onTap(BuildContext context) {
    final query = Uri.encodeComponent(token.href);
    context.go('/reference/details?href=$query');
  }
}
