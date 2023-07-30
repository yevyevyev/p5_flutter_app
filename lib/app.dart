import 'package:flutter/material.dart';
import 'package:p5_flutter_app/code_editor.dart';
import 'package:p5_flutter_app/p5_view.dart';

class P5FlutterApp extends StatelessWidget {
  const P5FlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: P5View(code: '''function setup() {
  createCanvas(screenWidth, screenHeight);
}

function draw() {
  background(255);
  if (mouseIsPressed) {
    fill(0);
  } else {
    fill(255);
  }
  ellipse(mouseX, mouseY, 80, 80);
}'''),
    );
  }
}
