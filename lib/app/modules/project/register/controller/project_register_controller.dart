import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:jobtimer/app/services/projects/project_service.dart';
import 'package:jobtimer/app/views_models/project_model.dart';

import '../../../../entities/project_satatus.dart';

part 'project_register_state.dart';

class ProjectRegisterController extends Cubit<ProjectRegisterStatus> {
  final ProjectService _projectService;
  ProjectRegisterController({required ProjectService projectService})
      : _projectService = projectService,
        super(ProjectRegisterStatus.inital);

  Future<void> register(String name, int estimate) async {
    try {
      emit(ProjectRegisterStatus.loading);
      final project = ProjectModel(
        name: name,
        estimate: estimate,
        status: ProjectStatus.em_andamento,
        tasks: [],
      );
      await _projectService.register(project);
      //await Future.delayed(const Duration(seconds: 2));
      emit(ProjectRegisterStatus.success);
    } catch (e, s) {
      log('Erro ao salvar projeto', error: e, stackTrace: s);
      emit(ProjectRegisterStatus.failure);
    }
  }
}
