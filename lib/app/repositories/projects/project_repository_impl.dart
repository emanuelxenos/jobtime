import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:jobtimer/app/core/database/database.dart';
import 'package:jobtimer/app/core/exceptions/failure.dart';
import 'package:jobtimer/app/entities/project.dart';
import 'package:jobtimer/app/entities/project_satatus.dart';
import 'package:jobtimer/app/entities/project_task.dart';

import './project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final Database _database;

  ProjectRepositoryImpl({required Database database}) : _database = database;

  Future<void> register(Project project) async {
    try {
      final connection = await _database.openConection();
      await connection.writeTxn((isar) {
        return isar.projects.put(project);
      });
    } on IsarError catch (e, s) {
      log('Erro ao cadastrar projeto', error: e, stackTrace: s);
      throw Failure(message: 'Erroa o cadastrar projeto');
    }
  }

  @override
  Future<List<Project>> findByStatus(ProjectStatus status) async {
    final connection = await _database.openConection();
    final projects =
        await connection.projects.filter().statusEqualTo(status).findAll();
    return projects;
  }

  @override
  Future<Project> addTask(int projectId, ProjectTask task) async {
    final connection = await _database.openConection();
    final project = await findById(projectId);

    project.tasks.add(task);

    await connection.writeTxn((isar) => project.tasks.save());
    return project;
  }

  @override
  Future<Project> findById(int projectId) async {
    final connection = await _database.openConection();
    final project = await connection.projects.get(projectId);
    if (project == null) {
      throw Failure(
          message:
              'Erro ao receber o id do projeto, repositoryImpl.dart - linha 50');
    }

    return project;
  }

  @override
  Future<void> finish(int projectId) async {
    try {
      final connection = await _database.openConection();
      final project = await findById(projectId);
      project.status = ProjectStatus.finalizado;
      await connection.writeTxn(
        (isar) => connection.projects.put(project, saveLinks: true),
      );
    } on IsarError catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      throw Failure(message: 'Erro ao finalizar projeto');
    }
  }
}
