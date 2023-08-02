import 'package:flutter_inappwebview/flutter_inappwebview.dart';

final webviewSettings = InAppWebViewSettings(
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

const screenWidthVarName = 'screenWidth';
const screenHeightVarName = 'screenHeight';
