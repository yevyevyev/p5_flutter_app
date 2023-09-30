import 'dart:async';

import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:p5_flutter_app/state/localhost_server/localhost_server.dart';
import 'package:p5_flutter_app/widgets/p5_view/webview_settings.dart';
import 'package:http/http.dart' as http;

const initialUrl = 'http://localhost:8080/p5.html';
const p5Url = 'http://localhost:8080/p5.min.js';
const p5SoundUrl = 'http://localhost:8080/p5.sound.min.js';

class P5ViewController {
  P5ViewController({
    required this.code,
    this.folder = '',
    this.isFullscreen = true,
  }) {
    _localhostErrorHandler = _localhostErrorStream.errorStream.listen((event) {
      addConsoleMessage(ConsoleMessage(
        message: event,
        messageLevel: ConsoleMessageLevel.ERROR,
      ));
    });
  }

  static Future<void> preload() async {
    await FkUserAgent.init();
    p5MinJsCode = await rootBundle.loadString('assets/p5.min.js');
    p5SoundMinJsCode = await rootBundle.loadString('assets/p5.sound.min.js');
    p5IndexHtml = await rootBundle.loadString('assets/p5.html');
    _localhostErrorStream = await startLocalhost();
  }

  static late final String p5MinJsCode;
  static late final String p5SoundMinJsCode;
  static late final String p5IndexHtml;
  static late final LocalHostServerErrorHandler _localhostErrorStream;
  final consoleMessages = ValueNotifier<List<ConsoleMessage>>([]);
  final isPageLoading = ValueNotifier(true);
  final String code;
  bool isFullscreen;
  String folder;
  final _sizeCompleter = Completer<Size>();

  void setScreenSize(BuildContext context, width, double height) {
    if (_sizeCompleter.isCompleted) {
      return;
    }

    if (isFullscreen) {
      width = MediaQuery.sizeOf(context).width;
      height = MediaQuery.sizeOf(context).height;
      _sizeCompleter.complete(Size(width, height));
    } else if (width > 0 && height > 0 && !_sizeCompleter.isCompleted) {
      _sizeCompleter.complete(Size(width, height));
    }
  }

  void addConsoleMessage(ConsoleMessage msg) {
    final value = consoleMessages.value;
    consoleMessages.value = [...value, msg];
  }

  void onWebViewCreated(InAppWebViewController controller) {
    _webViewController = controller;
  }

  void onLoadStop(InAppWebViewController controller, WebUri? uri) async {
    _webViewController = controller;
    try {
      final size = await _sizeCompleter.future;
      final resolvedCode = await _resolveCodeImports(code);
      final evalCode = '''
          $p5MinJsCode\n
          ${resolvedCode.contains('loadSound') ? p5SoundMinJsCode : ''}\n
          let $screenWidthVarName = ${size.width};
          let $screenHeightVarName = ${size.height};\n
          $resolvedCode
          ''';

      final res = await controller.evaluateJavascript(source: evalCode);
      print(res);
    } catch (e) {
      addConsoleMessage(
        ConsoleMessage(
          message: e.toString(),
          messageLevel: ConsoleMessageLevel.ERROR,
        ),
      );
    } finally {
      isPageLoading.value = false;
    }
  }

  Future<String> _resolveCodeImports(String code) async {
    final importRegex = RegExp(r"""import\s+([\'\"])(.*?)\1""");
    final matches = importRegex.allMatches(code);
    var resolvedCode = code;
    for (final match in matches) {
      final fileName = match.group(2)!;
      final uri = Uri.parse('http://localhost:8080/${folder}$fileName');
      final body = (await http.get(uri)).body;
      resolvedCode = code.replaceRange(match.start, match.end + 1, body);
    }

    return resolvedCode;
  }

  InAppWebViewController? _webViewController;
  StreamSubscription<String>? _localhostErrorHandler;

  void dispose() {
    _localhostErrorHandler?.cancel();
    _webViewController?.dispose();
  }
}
