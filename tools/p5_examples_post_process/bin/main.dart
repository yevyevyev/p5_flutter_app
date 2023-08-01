import 'dart:io';

void main(List<String> arguments) async {
  final c = File('p5_examples.json');
  var file = c.readAsStringSync();
  file = file.replaceAll(
      'createCanvas(710, 400', 'createCanvas(screenWidth, screenHeight');
  file = file.replaceAll(
      'createCanvas(720, 560', 'createCanvas(screenWidth, screenHeight');
  file = file.replaceAll(
      'createCanvas(400, 400', 'createCanvas(screenWidth, screenHeight');
  file = file.replaceAll(
      'createCanvas(720, 360', 'createCanvas(screenWidth, screenHeight');
  file = file.replaceAll(
      'createCanvas(400, 600', 'createCanvas(screenWidth, screenHeight');
  file = file.replaceAll(
      'createCanvas(600, 400', 'createCanvas(screenWidth, screenHeight');
  file = file.replaceAll(
      'createCanvas(720, 200', 'createCanvas(screenWidth, screenHeight');
  file = file.replaceAll(
      'createCanvas(640, 360', 'createCanvas(screenWidth, screenHeight');
  file = file.replaceAll(
      'createCanvas(500, 500', 'createCanvas(screenWidth, screenHeight');
  file = file.replaceAll(
      'createCanvas(600, 600', 'createCanvas(screenWidth, screenHeight');
  file = file.replaceAll(
      'createCanvas(710, 710', 'createCanvas(screenWidth, screenHeight');
  file = file.replaceAll(
      'createCanvas(200, 400', 'createCanvas(screenWidth, screenHeight');
  file = file.replaceAll(
      'createCanvas(700, 410', 'createCanvas(screenWidth, screenHeight');
  file = file.replaceAll(
      'createCanvas(320, 240', 'createCanvas(screenWidth, screenHeight');

  file = file.replaceAll(
      'createCanvas(200, 200', 'createCanvas(screenWidth, screenHeight');
  file = file.replaceAll(
      'createCanvas(720, 200', 'createCanvas(screenWidth, screenHeight');
  file = file.replaceAll(
      'createCanvas(710, 200', 'createCanvas(screenWidth, screenHeight');
  file = file.replaceAll(
      'createCanvas(710, 50', 'createCanvas(screenWidth, screenHeight');
  file = file.replaceAll(
      'createCanvas(710, 100', 'createCanvas(screenWidth, screenHeight');
  file = file.replaceAll(
      'createCanvas(720, 256', 'createCanvas(screenWidth, screenHeight');
  file = file.replaceAll(
      'createCanvas(710, 256', 'createCanvas(screenWidth, screenHeight');
  file = file.replaceAll(
      'createCanvas(720, 100', 'createCanvas(screenWidth, screenHeight');
  file = file.replaceAll(
      'createCanvas(800, 400', 'createCanvas(screenWidth, screenHeight');
  file = file.replaceAll('createCanvas(displayWidth, displayHeight',
      'createCanvas(screenWidth, screenHeight');
  final c2 = File('p5_examples_output.json');
  c2.writeAsStringSync(file);
}
