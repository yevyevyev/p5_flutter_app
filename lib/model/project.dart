import 'package:hive/hive.dart';

part 'project.g.dart';

const startingCode = '''function setup() {
  createCanvas(screenWidth, screenHeight);
}

function draw() {
  background(255, 50, 50);
}''';

@HiveType(typeId: 0)
class ProjectModel extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String code;
}
