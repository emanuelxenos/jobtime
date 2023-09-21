import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jobtimer/app/core/ui/job_xenos_icons.dart';
import 'package:jobtimer/app/modules/home/controller/home_controller.dart';
import 'package:jobtimer/app/views_models/project_model.dart';

class ProjectTile extends StatelessWidget {
  final ProjectModel projectModel;

  const ProjectTile({super.key, required this.projectModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Modular.to
            .popAndPushNamed('/project/detail', arguments: projectModel);
        Modular.get<HomeController>().updateList();
      },
      child: Container(
        constraints: const BoxConstraints(maxHeight: 90),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey[300]!,
              width: 4,
            )),
        child: Column(
          children: [
            _ProjectName(projectModel: projectModel),
            Expanded(child: _ProjectProgress(projectModel: projectModel)),
          ],
        ),
      ),
    );
  }
}

class _ProjectName extends StatelessWidget {
  final ProjectModel projectModel;
  const _ProjectName({required this.projectModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(projectModel.name),
          Icon(
            JobXenosIcons.angle_double_right,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}

class _ProjectProgress extends StatelessWidget {
  final ProjectModel projectModel;
  const _ProjectProgress({required this.projectModel});

  @override
  Widget build(BuildContext context) {
    final toltalTasks = projectModel.tasks
        .fold<int>(0, (previousValue, task) => previousValue += task.duration);
    var percent = 0.0;

    if (toltalTasks > 0) {
      percent = toltalTasks / projectModel.estimate;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: Colors.grey[400]!,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text('${projectModel.estimate}h'),
          ),
        ],
      ),
    );
  }
}
