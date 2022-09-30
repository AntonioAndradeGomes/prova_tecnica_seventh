import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_seventh/app/modules/login/login_page.dart';
import 'package:teste_seventh/app/modules/login/login_store.dart';
import 'package:teste_seventh/app/modules/login/repository/i_login_repository.dart';
import 'package:teste_seventh/app/modules/login/repository/login_repository.dart';
import 'package:teste_seventh/app/shared/dio/http_manager.dart';
import 'package:teste_seventh/app/shared/services/preference.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<ILoginRepository>(
      (i) => LoginRepository(
        httpManager: i<HttpManager>(),
      ),
    ),
    Bind.lazySingleton<LoginStore>(
      (i) => LoginStore(
        repository: i<ILoginRepository>(),
        preference: i<Preference>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const LoginPage(),
    ),
  ];
}
