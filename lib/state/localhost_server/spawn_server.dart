import 'package:flutter_isolate/flutter_isolate.dart';

import 'localhost_server_impl.dart';

@pragma('vm:entry-point')
void localhostEntrypoint(String msg) async {
  final localhostServer = CustomInAppLocalhostServer(
    directoryIndex: 'p5.html',
    shared: true,
    fileResolver: RootBundleFileResolver([
      'p5.html',
      'p5.min.js',
    ]),
  );
  await localhostServer.start();
}

Future<void> startLocalhost() => FlutterIsolate.spawn(localhostEntrypoint, '');
