import 'package:hive/hive.dart';

part 'project.g.dart';

@HiveType(typeId: 0)
class ProjectModel extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late DateTime createdAt;

  @HiveField(2)
  late DateTime updatedAt;
}
