import 'package:flutter_modular/flutter_modular.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mobx/mobx.dart';
import 'package:teste_seventh/app/shared/services/preference.dart';
import 'dart:developer' as developer;
part 'splash_store.g.dart';

class SplashStore = SplashStoreBase with _$SplashStore;

abstract class SplashStoreBase with Store {
  final Preference preference;

  SplashStoreBase({
    required this.preference,
  });

  Future<void> searchUser() async {
    developer.log(
      'Procurando usuário',
      name: 'Splash',
    );
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    final token = await preference.getToken();
    if (token == null) {
      developer.log(
        'usuário não existente',
        name: 'Splash',
      );
      Modular.to.navigate('/login/');
      return;
    }
    bool hasExpired = JwtDecoder.isExpired(token);
    developer.log(
      'user expirado? $hasExpired',
      name: 'Splash',
    );
    if (hasExpired) {
      await preference.logout();
      Modular.to.navigate('/login/');
    } else {
      Modular.to.navigate('/home/');
    }
  }
}
