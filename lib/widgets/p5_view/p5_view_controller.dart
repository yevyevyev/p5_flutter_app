import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:p5_flutter_app/state/localhost_server/localhost_server.dart';
import 'package:p5_flutter_app/widgets/p5_view/webview_settings.dart';

const initialUrl = 'http://localhost:8080/p5.html';
const p5Url = 'http://localhost:8080/p5.min.js';
const p5SoundUrl = 'http://localhost:8080/p5.sound.min.js';

class P5ViewController extends ChangeNotifier {
  P5ViewController(this.code, LocalHostServerErrorHandler handler) {
    _localhostErrorHandler = handler.errorStream.listen((event) {
      addConsoleMessage(ConsoleMessage(
        message: event,
        messageLevel: ConsoleMessageLevel.ERROR,
      ));
    });
  }

  List<ConsoleMessage> consoleMessages = [];
  double? screenWidth;
  double? screenHeight;
  var isPageLoading = true;
  final String code;

  void setScreenSize(double width, double height) {
    var shouldReload = false;
    if (screenHeight != null && screenHeight != height) {
      shouldReload = true;
    }
    if (screenWidth != null && screenWidth != width) {
      shouldReload = true;
    }
    screenHeight = height;
    screenWidth = width;
    if (shouldReload) {
      _webViewController?.reload();
    }
  }

  void addConsoleMessage(ConsoleMessage msg) {
    consoleMessages.add(msg);
    notifyListeners();
  }

  void onWebViewCreated(InAppWebViewController controller) {
    _webViewController = controller;
  }

  void onLoadStop(InAppWebViewController controller, WebUri? uri) async {
    _webViewController = controller;
    try {
      await controller.injectJavascriptFileFromUrl(urlFile: WebUri(p5Url));

      if (code.contains('loadSound')) {
        await controller.injectJavascriptFileFromUrl(
            urlFile: WebUri(p5SoundUrl));
      }

      await controller.evaluateJavascript(source: '''
          let $screenWidthVarName = $screenWidth;
          let $screenHeightVarName = $screenHeight;
          ''');

      await controller.evaluateJavascript(source: code);
    } catch (e) {
      addConsoleMessage(
        ConsoleMessage(
          message: e.toString(),
          messageLevel: ConsoleMessageLevel.ERROR,
        ),
      );
    } finally {
      isPageLoading = false;
      notifyListeners();
    }
  }

  InAppWebViewController? _webViewController;
  StreamSubscription<String>? _localhostErrorHandler;

  @override
  void dispose() {
    _localhostErrorHandler?.cancel();
    _webViewController?.dispose();
    super.dispose();
  }
}
