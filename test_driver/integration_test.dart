import 'dart:io';
import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  try {
    await integrationDriver(
      onScreenshot: (deviceName, bytes, [args]) async {
        final all = deviceName.split('/');
        deviceName = all.first;
        final index = all.last;
        final image = await File('screenshots/$deviceName/$index.png').create(recursive: true);
        image.writeAsBytesSync(bytes);
        return true;
      },
    );
  } catch (e) {
    print('Error occured: $e');
  }
}
