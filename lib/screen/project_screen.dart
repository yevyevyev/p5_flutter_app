import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p5_flutter_app/model/project.dart';
import 'package:p5_flutter_app/state/state.dart';
import 'package:p5_flutter_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProjectsNotifier extends ChangeNotifier {
  ProjectsNotifier(this.projectsRepository);

  void addProject(String name) {
    projectsRepository.addProject(name);
    notifyListeners();
  }

  List<ProjectModel> get data => projectsRepository.getAll();

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
            final projectName = await TextFieldDialog.show(
              context,
              title: 'Enter project name',
            );
            if (projectName != null) {
              // ignore: use_build_context_synchronously
              context.read<ProjectsNotifier>().addProject(projectName);
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
      onTap: () => context.push('/project/${project.key}'),
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
