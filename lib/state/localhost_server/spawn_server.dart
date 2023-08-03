import 'dart:isolate';

import 'package:flutter_isolate/flutter_isolate.dart';

import 'localhost_server_impl.dart';

@pragma('vm:entry-point')
void localhostEntrypoint(SendPort port) async {
  final localhostServer = CustomInAppLocalhostServer(
    directoryIndex: 'p5.html',
    shared: true,
    fileResolver: MultiFileResolver([
      RootBundleFileResolver([
        'p5.html',
        'p5.min.js',
      ]),
      AppDataFileResolver(),
    ]),
  );
  await localhostServer.start();
  localhostServer.errors.listen((e) => port.send(e.toString()));
}

class LocalHostServerErrorHandler {
  LocalHostServerErrorHandler(this.errorStream);
  final Stream<String> errorStream;
}

Future<LocalHostServerErrorHandler> startLocalhost() async {
  final port = ReceivePort();
  await FlutterIsolate.spawn(localhostEntrypoint, port.sendPort);
  return LocalHostServerErrorHandler(
      port.asBroadcastStream().map((event) => event.toString()));
}
