import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobtimer/app/services/projects/project_service.dart';
import 'package:jobtimer/app/views_models/project_model.dart';

part 'project_detail_state.dart';

class ProjectDetailController extends Cubit<ProjectDetailState> {
  final ProjectService _projectService;
  ProjectDetailController({required ProjectService projectService})
      : _projectService = projectService,
        super(ProjectDetailState.initial());

  void setProject(ProjectModel projectModel) {
    emit(state.copyWith(
        projectModel: projectModel, status: ProjectDetailStatus.complete));
  }

  Future<void> updateProject() async {
    final project = await _projectService.findById(state.projectModel!.id!);
    emit(state.copyWith(
        projectModel: project, status: ProjectDetailStatus.complete));
  }

  Future<void> finishProject() async {
    try {
      emit(state.copyWith(status: ProjectDetailStatus.loading));
      final projectId = state.projectModel!.id!;
      await _projectService.finish(projectId);
      updateProject();
    } catch (e) {
      emit(state.copyWith(status: ProjectDetailStatus.failure));
    }
  }
}
