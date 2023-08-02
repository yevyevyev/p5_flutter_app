import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p5_flutter_app/model/project.dart';
import 'package:p5_flutter_app/state/state.dart';
import 'package:provider/provider.dart';

class ProjectsNotifier extends ChangeNotifier {
  ProjectsNotifier(this.projectsRepository);

  void addProject(ProjectModel project) {
    projectsRepository.addProject(project);
    notifyListeners();
  }

  List<ProjectModel> get data => projectsRepository.projects.values.toList();

  final ProjectsRepository projectsRepository;
}

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProjectsNotifier(context.read()),
      builder: (context, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final projectName = await ProjectEnterNameDialog.show(context);
            if (projectName != null) {
              // ignore: use_build_context_synchronously
              context.read<ProjectsNotifier>().addProject(
                    ProjectModel()
                      ..name = projectName
                      ..code = startingCode,
                  );
            }
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          title: const Text(
            'Projects',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.black,
            ),
          ),
        ),
        body: const ProjectsScreenBody(),
      ),
    );
  }
}

class ProjectEnterNameDialog extends StatelessWidget {
  const ProjectEnterNameDialog({super.key});

  static Future<String?> show(BuildContext context) => showDialog(
        context: context,
        builder: (_) => const ProjectEnterNameDialog(),
      );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Enter project name',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              style: const TextStyle(fontSize: 20),
              textInputAction: TextInputAction.done,
              autofocus: true,
              onSubmitted: (value) => context.pop(value),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectsScreenBody extends StatelessWidget {
  const ProjectsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ProjectsNotifier>();

    if (notifier.data.isEmpty) {
      return const ProjectsScreenEmpty();
    }

    return ListView.separated(
      itemCount: notifier.data.length,
      itemBuilder: (context, index) =>
          ProjectListTile(project: notifier.data[index]),
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}

class ProjectListTile extends StatelessWidget {
  const ProjectListTile({super.key, required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.push('/project/editor', extra: project),
      title: Text(
        project.name,
        style: const TextStyle(fontSize: 20),
      ),
      leading: const Icon(Icons.folder, size: 60),
    );
  }
}

class ProjectsScreenEmpty extends StatelessWidget {
  const ProjectsScreenEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No Projects',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
