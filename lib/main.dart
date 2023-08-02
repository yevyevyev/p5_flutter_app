import 'package:flutter/material.dart';
import 'package:p5_flutter_app/app.dart';
import 'package:p5_flutter_app/state/state.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final referenceRepository = ReferenceRepository();
  await referenceRepository.preload();
  runApp(
    Provider.value(
      value: referenceRepository,
      child: const P5FlutterApp(),
    ),
  );
}
