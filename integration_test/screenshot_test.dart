import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:p5_flutter_app/app.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:p5_flutter_app/main.dart';

Future<String> getDeviceModel() async {
  String deviceModel;
  if (Platform.isAndroid) {
    deviceModel = (await DeviceInfoPlugin().androidInfo).model;
  } else {
    deviceModel = (await DeviceInfoPlugin().iosInfo).utsname.machine;
  }
  return deviceModel.replaceAll(' ', '_').toLowerCase();
}

final screenshotIndex = <String, int>{};

extension IntegrationTestWidgetsFlutterBindingX on IntegrationTestWidgetsFlutterBinding {
  Future<void> takeScreenshotX(WidgetTester tester) async {
    await convertFlutterSurfaceToImage();
    await tester.pumpAndSettle();
    final deviceModel = await getDeviceModel();
    final index = (screenshotIndex[deviceModel] ?? 0) + 1;
    screenshotIndex[deviceModel] = index;
    await takeScreenshot('$deviceModel/$index');
  }
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding();

  testWidgets('screenshot', (WidgetTester tester) async {
    final app = await initApp(const P5FlutterApp(), transientData: true);
    await tester.pumpWidget(app);
    await binding.takeScreenshotX(tester);

    await tester.tap(find.text('Examples'));
    await tester.pumpAndSettle();

    final scrollable = find.byType(Scrollable).first;
    await tester.dragUntil(find.text('Form'), scrollable);
    await binding.takeScreenshotX(tester);

    await tester.takeScreenshotExample(binding, 'wolfram', captureCode: true);
    await tester.takeScreenshotExample(binding, 'mandelbrot');
    await tester.takeScreenshotExample(binding, 'wavemaker');
    await tester.takeScreenshotExample(binding, 'game of life');
  });
}

extension WidgetTesterX on WidgetTester {
  Future<void> goBack() async {
    final center = getCenter(find.byType(Scaffold));
    final startLocation = Offset(0.0, center.dy);
    await dragFrom(startLocation, center.translate(center.dx, 0));
    await pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> takeScreenshotExample(
    IntegrationTestWidgetsFlutterBinding binding,
    String searchToken, {
    bool captureCode = false,
  }) async {
    await pumpAndSettle(const Duration(seconds: 1));
    final search = find.byType(CupertinoSearchTextField);
    await tap(search);
    await pumpAndSettle();
    final cancel = find.byIcon(CupertinoIcons.xmark_circle_fill);
    if (cancel.evaluate().isNotEmpty) {
      await tap(cancel, warnIfMissed: false);
      await pumpAndSettle(const Duration(seconds: 2));
    }

    testTextInput.enterText(searchToken);
    await pumpAndSettle();
    await tap(find.byType(Card).first, warnIfMissed: false);

    if (captureCode) {
      await binding.takeScreenshotX(this);
    }

    await pumpAndSettle(const Duration(seconds: 1));
    await tap(find.byType(FloatingActionButton));
    await pumpAndSettle(const Duration(seconds: 5));
    await binding.takeScreenshotX(this);
    await goBack();
    await goBack();
  }

  Future<void> dragUntil(
    Finder finder,
    Finder view,
  ) async {
    const pointer = 100;
    while (finder.evaluate().isEmpty) {
      await drag(
        view,
        const Offset(0, -100),
        pointer: pointer,
      );
      await pump(Duration(milliseconds: 100));
    }
    binding.cancelPointer(pointer);
  }
}
