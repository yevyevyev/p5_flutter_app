import 'dart:io';
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;

import 'mime_type_resolver.dart';

abstract class FileResolver {
  Future<Uint8List> getFile(String key);
}

class RootBundleFileResolver implements FileResolver {
  Map<String, Uint8List> _cache = {};
  List<String> cacheKeys;

  RootBundleFileResolver(this.cacheKeys);

  @override
  Future<Uint8List> getFile(String key) async {
    final path = 'assets/$key';
    loadData() async => (await rootBundle.load(path)).buffer.asUint8List();

    if (cacheKeys.contains(key)) {
      if (!_cache.containsKey(key)) {
        _cache[key] = await loadData();
      }
      return _cache[key]!;
    }
    return loadData();
  }
}

class CustomInAppLocalhostServer {
  bool _started = false;
  HttpServer? _server;
  int _port = 8080;
  bool _shared = false;
  String _directoryIndex = 'index.html';
  late FileResolver _fileResolver;
  final _streamErrors = StreamController<Object>.broadcast();
  Stream<Object> get errors => _streamErrors.stream;

  CustomInAppLocalhostServer({
    int port = 8080,
    String directoryIndex = 'index.html',
    bool shared = false,
    required FileResolver fileResolver,
  }) {
    _port = port;
    _directoryIndex = directoryIndex;
    _shared = shared;
    _fileResolver = fileResolver;
  }

  Future<void> start() async {
    if (_started) {
      throw Exception('Server already started on http://localhost:$_port');
    }
    _started = true;

    var completer = Completer();

    runZonedGuarded(() {
      HttpServer.bind('127.0.0.1', _port, shared: _shared).then((server) {
        print('Server running on http://localhost:' + _port.toString());

        _server = server;

        server.listen((HttpRequest request) async {
          Uint8List body = Uint8List(0);

          var path = request.requestedUri.path;
          path = (path.startsWith('/')) ? path.substring(1) : path;
          path += (path.endsWith('/')) ? _directoryIndex : '';
          if (path == '') {
            path = _directoryIndex;
          }

          try {
            body = await _fileResolver.getFile(path);
          } catch (e) {
            _streamErrors.add(e);
            request.response.close();
            return;
          }

          var contentType = ContentType('text', 'html', charset: 'utf-8');
          if (!request.requestedUri.path.endsWith('/') &&
              request.requestedUri.pathSegments.isNotEmpty) {
            var mimeType = MimeTypeResolver.lookup(request.requestedUri.path);
            if (mimeType != null) {
              contentType = _getContentTypeFromMimeType(mimeType);
            }
          }

          request.response.headers.contentType = contentType;
          request.response.add(body);
          request.response.close();
        });

        completer.complete();
      });
    }, (e, stackTrace) => print('Error: $e $stackTrace'));

    return completer.future;
  }

  ///Closes the server.
  Future<void> close() async {
    if (_server == null) {
      return;
    }
    _streamErrors.close();
    await _server!.close(force: true);
    print('Server running on http://localhost:$_port closed');
    _started = false;
    _server = null;
  }

  bool isRunning() {
    return _server != null;
  }

  ContentType _getContentTypeFromMimeType(String mimeType) {
    final contentType = mimeType.split('/');
    String? charset;

    if (_isTextFile(mimeType)) {
      charset = 'utf-8';
    }

    return ContentType(contentType[0], contentType[1], charset: charset);
  }

  bool _isTextFile(String mimeType) {
    final textFile = RegExp(r'^text\/|^application\/(javascript|json)');
    return textFile.hasMatch(mimeType);
  }
}
