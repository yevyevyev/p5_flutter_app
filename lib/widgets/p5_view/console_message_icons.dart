import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
