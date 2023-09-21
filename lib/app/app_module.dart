import 'package:flutter_modular/flutter_modular.dart';
import 'package:jobtimer/app/core/database/database.dart';
import 'package:jobtimer/app/core/database/database_impl.dart';
import 'package:jobtimer/app/modules/home/home_module.dart';
import 'package:jobtimer/app/modules/login/login_module.dart';
import 'package:jobtimer/app/modules/project/register/project_module.dart';
import 'package:jobtimer/app/modules/splash/splash_page.dart';
import 'package:jobtimer/app/repositories/projects/project_repository.dart';
import 'package:jobtimer/app/repositories/projects/project_repository_impl.dart';
import 'package:jobtimer/app/services/auth/auth_sersvice.dart';
import 'package:jobtimer/app/services/auth/auth_sersvice_impl.dart';
import 'package:jobtimer/app/services/projects/project_service.dart';
import 'package:jobtimer/app/services/projects/project_service_impl.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<AuthSersvice>((i) => AuthSersviceImpl()),
        Bind.lazySingleton<Database>((i) => DatabaseImpl()),
        Bind.lazySingleton<ProjectRepository>(
            (i) => ProjectRepositoryImpl(database: i())),
        Bind.lazySingleton<ProjectService>(
            (i) => ProjectServiceImpl(projectRepository: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: ((context, args) => const SplashPage())),
        ModuleRoute('/login', module: LoginModule()),
        ModuleRoute('/home', module: HomeModule()),
        ModuleRoute('/project', module: ProjectModule()),
      ];
}
