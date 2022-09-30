import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:teste_seventh/app/modules/login/repository/i_login_repository.dart';
import 'package:teste_seventh/app/shared/services/preference.dart';
part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  ILoginRepository repository;
  Preference preference;

  LoginStoreBase({
    required this.repository,
    required this.preference,
  });

  @observable
  bool isLoading = false;

  @action
  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    try {
      isLoading = true;
      final result = await repository.login(
        username: username,
        password: password,
      );
      await preference.setToken(result);
      Modular.to.pushNamed('/home/');
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
    }
  }
}
