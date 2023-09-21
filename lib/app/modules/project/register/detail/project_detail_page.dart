import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobtimer/app/core/ui/job_xenos_icons.dart';
import 'package:jobtimer/app/entities/project_satatus.dart';
import 'package:jobtimer/app/modules/project/register/detail/controller/project_detail_controller.dart';
import 'package:jobtimer/app/modules/project/register/detail/widgets/project_detail_appbar.dart';
import 'package:jobtimer/app/modules/project/register/detail/widgets/project_pie_chart.dart';
import 'package:jobtimer/app/modules/project/register/detail/widgets/project_task_tile.dart';
import 'package:jobtimer/app/views_models/project_model.dart';

class ProjectDetailPage extends StatelessWidget {
  final ProjectDetailController controller;
  const ProjectDetailPage({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProjectDetailController, ProjectDetailState>(
        bloc: controller,
        listener: (context, state) {
          if (state.status == ProjectDetailStatus.failure) {
            AsukaSnackbar.alert("Erro interno").show();
          }
        },
        builder: (context, state) {
          final projectModel = state.projectModel;
          switch (state.status) {
            case ProjectDetailStatus.initial:
              return const Center(
                child: Text('Carregando projeto'),
              );

            case ProjectDetailStatus.loading:
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );

            case ProjectDetailStatus.complete:
              return _buildProjectDetail(context, projectModel!);

            case ProjectDetailStatus.failure:
              if (projectModel != null) {
                return _buildProjectDetail(context, projectModel);
              }
              return const Center(
                child: Text('Erro ao carregar projeto'),
              );
          }
        },
      ),
    );
  }

  Widget _buildProjectDetail(BuildContext context, ProjectModel projectModel) {
    final totalTask = projectModel.tasks.fold<int>(
      0,
      (totalValue, task) {
        return totalValue += task.duration;
      },
    );
    return CustomScrollView(slivers: [
      ProjectDetailAppbar(
        projectModel: projectModel,
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          [
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 50),
              child: ProjectPieChart(
                projectEstimate: projectModel.estimate,
                totalTask: totalTask,
              ),
            ),
            ...projectModel.tasks
                .map((task) => ProjectTaskTile(
                      task: task,
                    ))
                .toList(),
          ],
        ),
      ),
      SliverFillRemaining(
        hasScrollBody: false,
        child: Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Visibility(
              visible: projectModel.status != ProjectStatus.finalizado,
              child: ElevatedButton.icon(
                onPressed: () {
                  controller.finishProject();
                },
                icon: const Icon(JobXenosIcons.ok_circled2),
                label: const Text("Finalizar Projeto"),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
