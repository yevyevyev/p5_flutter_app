import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:p5_flutter_app/model/reference.dart';

class ReferenceRepository {
  List<ReferenceGroupModel> data = [];
  List<ReferenceTokenModel> tokens = [];

  Future<void> preload() async {
    final file = await rootBundle.loadString('assets/p5_reference.json');
    final json = jsonDecode(file) as List;
    data = json.map((e) => ReferenceGroupModel.fromJson(e)).toList();
    tokens = data
        .expand((e) => e.subgroups.expand((e) => e.tokens).toList())
        .toList();
  }

  List<ReferenceTokenModel> searchTokens(String search) => tokens
      .where((e) => e.label.toLowerCase().contains(search.toLowerCase()))
      .toList();

  ReferenceTokenModel? getTokenByHref(String href) =>
      tokens.where((e) => e.href == href).firstOrNull;
}
