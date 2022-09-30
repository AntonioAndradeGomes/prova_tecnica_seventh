import 'package:teste_seventh/app/modules/splash/splash_page.dart';
import 'package:teste_seventh/app/modules/splash/splash_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_seventh/app/shared/services/preference.dart';

class SplashModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<SplashStore>(
      (i) => SplashStore(
        preference: i<Preference>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const SplashPage(),
    ),
  ];
}
