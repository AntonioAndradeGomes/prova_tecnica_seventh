import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_seventh/app/modules/home/home_module.dart';
import 'package:teste_seventh/app/modules/login/login_module.dart';
import 'package:teste_seventh/app/modules/splash/splash_module.dart';
import 'package:teste_seventh/app/shared/dio/http_manager.dart';
import 'package:teste_seventh/app/shared/services/preference.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton<Preference>(
      (i) => Preference(),
    ),
    Bind.singleton<HttpManager>(
      (i) => HttpManager(),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      Modular.initialRoute,
      module: SplashModule(),
    ),
    ModuleRoute(
      '/login',
      module: LoginModule(),
    ),
    ModuleRoute(
      '/home',
      module: HomeModule(),
    ),
  ];
}
