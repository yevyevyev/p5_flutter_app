import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

const screenWidthVarName = 'screenWidth';
const screenHeightVarName = 'screenHeight';

class P5View extends StatefulWidget {
  const P5View({
    super.key,
    required this.code,
    this.keepAlive,
  });

  final String code;
  final InAppWebViewKeepAlive? keepAlive;

  @override
  State<P5View> createState() => _P5ViewState();
}

class _P5ViewState extends State<P5View> {
  String? error;
  double? screenWidth;
  double? screenHeight;

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
      webViewController?.reload();
    }
  }

  InAppWebViewController? webViewController;
  final settings = InAppWebViewSettings(
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllow: "camera; microphone",
    iframeAllowFullscreen: true,
    verticalScrollBarEnabled: false,
    horizontalScrollBarEnabled: false,
    disableVerticalScroll: true,
    disableHorizontalScroll: true,
    supportZoom: false,
    overScrollMode: OverScrollMode.NEVER,
    disableLongPressContextMenuOnLinks: true,
    disableContextMenu: true,
    isInspectable: true,
  );

  @override
  void didUpdateWidget(covariant P5View oldWidget) {
    if (widget.code != oldWidget.code) {
      error = null;
      webViewController?.reload();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    webViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return Material(child: Center(child: Text(error!)));
    }

    return GestureDetector(
      onLongPressDown: (details) {},
      child: LayoutBuilder(builder: (context, constraints) {
        setScreenSize(constraints.maxWidth, constraints.maxHeight);
        return InAppWebView(
          keepAlive: widget.keepAlive,
          contextMenu: null,
          initialUrlRequest:
              URLRequest(url: WebUri('http://localhost:8080/p5.html')),
          onConsoleMessage: (controller, consoleMessage) {
            if (consoleMessage.messageLevel == ConsoleMessageLevel.ERROR) {
              setState(() => error = consoleMessage.message);
            }
          },
          onLoadStart: (controller, url) {
            print(url);
          },
          onLoadStop: (controller, url) async {
            try {
              await controller.injectJavascriptFileFromUrl(
                urlFile: WebUri('http://localhost:8080/p5.min.js'),
              );

              await controller.evaluateJavascript(source: '''
    let $screenWidthVarName = $screenWidth;
    let $screenHeightVarName = $screenHeight;
    ''');

              final res =
                  await controller.evaluateJavascript(source: widget.code);
              print(res);
            } catch (e) {
              print(e);
            }
          },
          initialSettings: settings,
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          onReceivedError: (controller, request, error) {
            print(error);
          },
          onReceivedHttpError: (controller, request, errorResponse) {
            print(errorResponse);
          },
        );
      }),
    );
  }
}
