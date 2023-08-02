import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:p5_flutter_app/widgets/p5_view/console_message_icons.dart';

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
