import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p5_flutter_app/model/model.dart';
import 'package:p5_flutter_app/state/examples_repository.dart';
import 'package:p5_flutter_app/state/projects_repository.dart';
import 'package:p5_flutter_app/state/reference_repository.dart';

final examplesRepositoryProvider = Provider<ExamplesRepository>((ref) => throw UnimplementedError());
final projectsRepositoryProvider = Provider<ProjectsRepository>((ref) => throw UnimplementedError());
final referenceRepositoryProvider = Provider<ReferenceRepository>((ref) => throw UnimplementedError());

final examplesByNameProvider = Provider.family.autoDispose<List<ExampleModel>, String>((ref, name) {
  final examples = ref.watch(examplesRepositoryProvider);
  return examples.searchByName(name);
});

final currentProjectIdProvider = Provider<int>((ref) => throw UnimplementedError());

final currentProjectProvider = Provider.autoDispose(
  (ref) {
    final projects = ref.watch(projectsRepositoryProvider);
    final projectId = ref.watch(currentProjectIdProvider);
    return projects.get(projectId)!;
  },
  dependencies: [
    currentProjectIdProvider,
  ],
  name: 'currentProjectProvider',
);

final currentProjectFilesProvider = StreamProvider.autoDispose(
  (ref) {
    final project = ref.watch(currentProjectProvider);
    return project.watchFiles();
  },
  dependencies: [
    currentProjectIdProvider,
    currentProjectProvider,
  ],
  name: 'currentProjectFilesProvider',
);

final allExamplesProvider = Provider.autoDispose((ref) {
  final examples = ref.watch(examplesRepositoryProvider);
  return examples.examples;
});

final allExamplesGroupedProvider = Provider.autoDispose((ref) {
  final examples = ref.watch(examplesRepositoryProvider);
  return examples.data;
});

final allProjectsProvider = StreamProvider.autoDispose((ref) {
  final projects = ref.watch(projectsRepositoryProvider);
  return projects.watchAll();
});
