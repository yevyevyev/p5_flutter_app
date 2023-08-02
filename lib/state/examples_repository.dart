import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:p5_flutter_app/model/example.dart';

class ExamplesRepository {
  List<ExampleGroupModel> data = [];
  List<ExampleModel> examples = [];

  Future<void> preload() async {
    final file = await rootBundle.loadString('assets/p5_examples.json');
    final json = jsonDecode(file) as List;
    data = json.map((e) => ExampleGroupModel.fromJson(e)).toList();
    examples = data.expand((e) => e.examples).toList();
  }
}
