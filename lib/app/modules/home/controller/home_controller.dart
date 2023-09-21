import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jobtimer/app/services/projects/project_service.dart';
import 'package:jobtimer/app/views_models/project_model.dart';

import '../../../entities/project_satatus.dart';

part 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  ProjectService _projectService;

  HomeController({required ProjectService projectService})
      : _projectService = projectService,
        super(HomeState.initial());

  Future<void> loadProjects() async {
    try {
      emit(state.copyWith(status: HomeStatus.loadind));
      final projects = await _projectService.findByStatus(state.projectFilter);
      emit(state.copyWith(status: HomeStatus.complete, projects: projects));
    } catch (e, s) {
      log('Erro ao buscar os projetos', error: e, stackTrace: s);
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> filter(ProjectStatus status) async {
    emit(state.copyWith(status: HomeStatus.loadind, projects: []));
    final projects = await _projectService.findByStatus(status);
    emit(
      state.copyWith(
        status: HomeStatus.complete,
        projects: projects,
        projectFilter: status,
      ),
    );
  }

  void updateList() => filter(state.projectFilter);
}
