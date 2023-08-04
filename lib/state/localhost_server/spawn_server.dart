import 'dart:isolate';

import 'package:flutter_isolate/flutter_isolate.dart';

import 'localhost_server_impl.dart';

@pragma('vm:entry-point')
void localhostEntrypoint(SendPort port) async {
  const precache = [
    'p5.html',
    'p5.min.js',
    'p5.sound.min.js',
  ];
  final rootBundleFileResolver = RootBundleFileResolver();
  final inMemoryFileResolver = InMemoryFileResolver();
  await Future.wait(
    precache.map((e) async =>
        inMemoryFileResolver.put(e, await rootBundleFileResolver.getFile(e))),
  );

  final localhostServer = CustomInAppLocalhostServer(
    directoryIndex: 'p5.html',
    shared: true,
    fileResolver: MultiFileResolver([
      inMemoryFileResolver,
      rootBundleFileResolver,
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
