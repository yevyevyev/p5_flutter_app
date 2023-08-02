import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:p5_flutter_app/state/localhost_server/localhost_server_impl.dart';
import 'package:provider/provider.dart';

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
  List<ConsoleMessage> consoleMessages = [];
  double? screenWidth;
  double? screenHeight;
  StreamSubscription<Object>? _localServerErrorListener;

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
  void didChangeDependencies() {
    _localServerErrorListener ??=
        context.read<CustomInAppLocalhostServer>().errors.listen((event) {
      addConsoleMessage(
        ConsoleMessage(
          message: event.toString(),
          messageLevel: ConsoleMessageLevel.ERROR,
        ),
      );
    });
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant P5View oldWidget) {
    if (widget.code != oldWidget.code) {
      webViewController?.reload();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    webViewController?.dispose();
    _localServerErrorListener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressDown: (details) {},
      child: LayoutBuilder(builder: (context, constraints) {
        setScreenSize(constraints.maxWidth, constraints.maxHeight);
        return Stack(
          children: [
            buildWebView(),
            if (consoleMessages.isNotEmpty)
              Align(
                alignment: Alignment.bottomCenter,
                child: ConsoleMessageList(consoleMessages: consoleMessages),
              )
          ],
        );
      }),
    );
  }

  void addConsoleMessage(ConsoleMessage msg) {
    consoleMessages.add(msg);
    setState(() {});
  }

  Widget buildWebView() => InAppWebView(
        keepAlive: widget.keepAlive,
        contextMenu: null,
        initialUrlRequest:
            URLRequest(url: WebUri('http://localhost:8080/p5.html')),
        onConsoleMessage: (controller, consoleMessage) =>
            addConsoleMessage(consoleMessage),
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

            await controller.evaluateJavascript(source: widget.code);
          } catch (e) {
            addConsoleMessage(
              ConsoleMessage(
                message: e.toString(),
                messageLevel: ConsoleMessageLevel.ERROR,
              ),
            );
          }
        },
        initialSettings: settings,
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        onContentSizeChanged: (controller, oldContentSize, newContentSize) {
          if (newContentSize.width < screenWidth! &&
              newContentSize.height < screenHeight!) {}
        },
        onReceivedError: (controller, request, error) {
          print(error);
        },
        onReceivedHttpError: (controller, request, errorResponse) {
          print(errorResponse);
        },
      );
}

class ConsoleMessageList extends StatelessWidget {
  const ConsoleMessageList({
    super.key,
    required this.consoleMessages,
  });

  final List<ConsoleMessage> consoleMessages;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.4,
      child: Card(
          child: ListView(
        children: consoleMessages.map(buildMessage).toList(),
      )),
    );
  }

  Widget buildMessage(ConsoleMessage message) {
    return ListTile(
      title: Text(message.message),
      trailing: message.messageLevel.toIcon(),
    );
  }
}

extension ConsoleMessageLevelX on ConsoleMessageLevel {
  Icon? toIcon() {
    if (this == ConsoleMessageLevel.ERROR) {
      return const Icon(
        Icons.error,
        color: Colors.red,
      );
    }

    if (this == ConsoleMessageLevel.DEBUG) {
      return const Icon(
        Icons.bug_report,
        color: Colors.black,
      );
    }

    if (this == ConsoleMessageLevel.LOG) {
      return const Icon(
        Icons.print,
        color: Colors.black,
      );
    }

    if (this == ConsoleMessageLevel.WARNING) {
      return const Icon(
        Icons.warning,
        color: Colors.yellow,
      );
    }

    return null;
  }
}
