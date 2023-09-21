import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jobtimer/app/modules/project/register/controller/project_register_controller.dart';
import 'package:jobtimer/app/modules/project/register/project_register_page.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class ProjectRegisterModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        BlocBind.lazySingleton((i) => ProjectRegisterController(
            projectService: i())), //Dependência vem de AppModule
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (context, args) => ProjectRegisterPage(
                  controller: Modular.get(),
                )),
      ];
}
