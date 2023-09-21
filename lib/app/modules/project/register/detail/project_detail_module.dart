import 'package:flutter_modular/flutter_modular.dart';
import 'package:jobtimer/app/modules/project/register/detail/controller/project_detail_controller.dart';
import 'package:jobtimer/app/modules/project/register/detail/project_detail_page.dart';
import 'package:jobtimer/app/views_models/project_model.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class ProjectDetailModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        BlocBind.lazySingleton(
          (i) => ProjectDetailController(projectService: i()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) {
          final ProjectModel projectModel = args.data;
          return ProjectDetailPage(
              controller: Modular.get()..setProject(projectModel));
        }),
      ];
}
