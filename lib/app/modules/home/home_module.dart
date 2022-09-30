import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_seventh/app/modules/home/repository/i_video_repository.dart';
import 'package:teste_seventh/app/modules/home/repository/video_repository.dart';
import 'package:teste_seventh/app/shared/dio/http_manager.dart';
import 'package:teste_seventh/app/shared/services/preference.dart';
import '../home/home_store.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<IVideoRepository>(
      (i) => VideoRepository(
        httpManager: i<HttpManager>(),
      ),
    ),
    Bind.lazySingleton<HomeStore>(
      (i) => HomeStore(
        preference: i<Preference>(),
        repository: i<IVideoRepository>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const HomePage(),
    ),
  ];
}
