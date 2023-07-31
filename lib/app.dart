import 'package:flutter/material.dart';
import 'package:p5_flutter_app/code_editor.dart';

const example1 = '''function setup() {
  createCanvas(100, 100, WEBGL);
  normalMaterial();
  describe(
    'Camera orbits around a box when mouse is hold-clicked & then moved.'
  );
}
function draw() {
  background(200);

  // If you execute the line commented out instead of next line, the direction of rotation
  // will be the direction the mouse or touch pointer moves, not around the X or Y axis.
  orbitControl();
  // orbitControl(1, 1, 1, {freeRotation: true});

  rotateY(0.5);
  box(30, 50);
}''';

const example2 = '''function setup() {
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
}''';

class P5FlutterApp extends StatelessWidget {
  const P5FlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CodeEditorWidget(initialCode: example1),
    );
  }
}
