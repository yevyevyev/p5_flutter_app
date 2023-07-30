import 'package:flutter/material.dart';

// TODO: add multitouch handling to p5.js

class MultiTouchProvider extends StatefulWidget {
  const MultiTouchProvider({super.key, required this.child});

  final Widget child;

  @override
  State<MultiTouchProvider> createState() => _MultiTouchProviderState();
}

class _MultiTouchProviderState extends State<MultiTouchProvider> {
  final pointers = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: widget.child,
    );
  }
}
