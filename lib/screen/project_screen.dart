import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:p5_flutter_app/model/project.dart';
import 'package:p5_flutter_app/state/state.dart';
import 'package:p5_flutter_app/widgets/widgets.dart';

class ProjectScreen extends ConsumerWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final projectName = await TextFieldDialog.show(
            context,
            title: 'Enter project name',
          );
          if (projectName != null) {
            ref.read(projectsRepositoryProvider).addProject(projectName);
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
    );
  }
}

class ProjectsScreenBody extends ConsumerWidget {
  const ProjectsScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(allProjectsProvider);

    return projects.when(
      data: (data) => ListView.separated(
        itemCount: data.length,
        itemBuilder: (context, index) => ProjectListTile(project: data[index]),
        separatorBuilder: (context, index) => const Divider(),
      ),
      error: (error, _) => Center(child: Text(error.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
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
