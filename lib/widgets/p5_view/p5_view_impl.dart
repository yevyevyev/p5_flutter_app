import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:p5_flutter_app/widgets/p5_view/console_message_list.dart';
import 'package:p5_flutter_app/widgets/p5_view/p5_view_controller.dart';
import 'package:p5_flutter_app/widgets/p5_view/webview_settings.dart';

class P5View extends StatelessWidget {
  const P5View({
    super.key,
    this.showConsole = true,
    required this.p5controller,
  });

  final bool showConsole;
  final P5ViewController p5controller;

  @override
  Widget build(BuildContext context) {
    return buildWebView();
  }

  Widget buildWebView() {
    return Stack(
      children: [
        Positioned.fill(
          child: LayoutBuilder(builder: (context, constraints) {
            p5controller.setScreenSize(
              context,
              constraints.maxWidth,
              constraints.maxHeight,
            );
            return const SizedBox();
          }),
        ),
        InAppWebView(
          key: key,
          contextMenu: null,
          initialData: InAppWebViewInitialData(
            data: P5ViewController.p5IndexHtml,
            baseUrl: WebUri('http://localhost:8080/${p5controller.folder}p5.html'),
          ),
          onConsoleMessage: (controller, consoleMessage) => p5controller.addConsoleMessage(consoleMessage),
          onLoadStop: p5controller.onLoadStop,
          initialSettings: webviewSettings,
          onWebViewCreated: p5controller.onWebViewCreated,
          onReceivedError: (controller, request, error) {
            p5controller.addConsoleMessage(
              ConsoleMessage(
                message: '${error.description}\n${request.url}',
                messageLevel: ConsoleMessageLevel.ERROR,
              ),
            );
          },
          onReceivedHttpError: (controller, request, errorResponse) {
            print(errorResponse);
          },
        ),
        buildPageLoadingIndicator(),
        if (showConsole) buildConsoleMessageList(),
      ],
    );
  }

  Widget buildConsoleMessageList() => ValueListenableBuilder(
        valueListenable: p5controller.consoleMessages,
        builder: (context, value, child) {
          if (value.isNotEmpty) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: ConsoleMessageList(consoleMessages: value),
            );
          }

          return const SizedBox();
        },
      );

  Widget buildPageLoadingIndicator() => ValueListenableBuilder(
        valueListenable: p5controller.isPageLoading,
        builder: (context, value, child) {
          if (value) {
            return const Center(child: CupertinoActivityIndicator());
          }

          return const SizedBox();
        },
      );
}
