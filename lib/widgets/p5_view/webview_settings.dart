import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fk_user_agent/fk_user_agent.dart';

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
  builtInZoomControls: false,
  overScrollMode: OverScrollMode.NEVER,
  disableLongPressContextMenuOnLinks: true,
  disableContextMenu: true,
  isInspectable: true,
  transparentBackground: true,
  needInitialFocus: false,
  allowsBackForwardNavigationGestures: false,
  allowsLinkPreview: false,
  userAgent: FkUserAgent.userAgent,
);

const screenWidthVarName = 'screenWidth';
const screenHeightVarName = 'screenHeight';
