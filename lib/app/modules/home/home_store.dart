import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:teste_seventh/app/modules/home/repository/i_video_repository.dart';
import 'package:teste_seventh/app/shared/config/failure.dart';
import 'package:teste_seventh/app/shared/services/preference.dart';
import 'dart:developer' as developer;
part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final Preference preference;
  final IVideoRepository repository;

  HomeStoreBase({
    required this.preference,
    required this.repository,
  });

  @observable
  bool isLoading = true;

  @observable
  String? urlVideo;

  @action
  Future<void> getUrlVideo() async {
    try {
      developer.log(
        'Buscando user e a url do vídeo',
        name: 'Home',
      );
      isLoading = true;
      urlVideo = null;
      final token = await preference.getToken();
      final result = await repository.getUrlVideo(
        token: token!,
      );
      developer.log(
        'Url: $result',
        name: 'Home',
      );
      urlVideo = result;
    } on Failure catch (e) {
      if (e.code == 401) {
        developer.log(
          'Retorno não autorizado, deslogando user',
          name: 'Home Error',
        );
        await preference.logout();
        Modular.to.navigate('/');
        isLoading = false;
        return;
      }
      developer.log(
        'Vídeo não encontrado',
        name: 'Home Error',
      );
      urlVideo = null;
    } finally {
      isLoading = false;
    }
  }

  Future<void> logoff() async {
    developer.log(
      'Deslogando user',
      name: 'Home',
    );
    await preference.logout();
    Modular.to.navigate('/');
  }
}
