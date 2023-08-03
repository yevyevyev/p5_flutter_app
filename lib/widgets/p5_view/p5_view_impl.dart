import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:p5_flutter_app/widgets/p5_view/console_message_list.dart';
import 'package:p5_flutter_app/widgets/p5_view/p5_view_controller.dart';
import 'package:p5_flutter_app/widgets/p5_view/webview_settings.dart';
import 'package:provider/provider.dart';

class P5View extends StatelessWidget {
  const P5View({super.key, this.showConsole = true});

  final bool showConsole;

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<P5ViewController>();
    return GestureDetector(
      onLongPressDown: (details) {},
      child: LayoutBuilder(builder: (context, constraints) {
        notifier.setScreenSize(constraints.maxWidth, constraints.maxHeight);
        if (!showConsole) {
          return buildWebView(notifier);
        }

        return Stack(
          children: [
            buildWebView(notifier),
            if (notifier.consoleMessages.isNotEmpty)
              Align(
                alignment: Alignment.bottomCenter,
                child: ConsoleMessageList(
                  consoleMessages: notifier.consoleMessages,
                ),
              ),
            if (notifier.isPageLoading)
              const Center(child: CupertinoActivityIndicator())
          ],
        );
      }),
    );
  }

  Widget buildWebView(P5ViewController notifier) => InAppWebView(
        key: key,
        contextMenu: null,
        initialUrlRequest: URLRequest(url: WebUri(initialUrl)),
        onConsoleMessage: (controller, consoleMessage) =>
            notifier.addConsoleMessage(consoleMessage),
        onLoadStop: notifier.onLoadStop,
        initialSettings: webviewSettings,
        onWebViewCreated: notifier.onWebViewCreated,
        onReceivedError: (controller, request, error) {
          print(error);
        },
        onReceivedHttpError: (controller, request, errorResponse) {
          print(errorResponse);
        },
      );
}
