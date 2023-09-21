import 'package:jobtimer/app/entities/project.dart';
import 'package:jobtimer/app/entities/project_satatus.dart';
import 'package:jobtimer/app/views_models/project_model.dart';
import 'package:jobtimer/app/views_models/project_task_model.dart';

abstract class ProjectService {
  Future<void> register(ProjectModel projectModel);
  Future<List<ProjectModel>> findByStatus(ProjectStatus status);
  Future<ProjectModel> findById(int projectId);
  Future<ProjectModel> addTask(int projectId, ProjectTaskModel task);
  Future<void> finish(int projectId);
}
