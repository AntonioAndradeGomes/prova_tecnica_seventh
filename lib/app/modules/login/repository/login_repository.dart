import 'package:teste_seventh/app/modules/login/repository/i_login_repository.dart';
import 'package:teste_seventh/app/shared/config/failure.dart';
import 'package:teste_seventh/app/shared/constants/api_paths.dart';
import 'package:teste_seventh/app/shared/constants/http_methods.dart';
import 'package:teste_seventh/app/shared/dio/http_manager.dart';

class LoginRepository extends ILoginRepository {
  final HttpManager httpManager;

  LoginRepository({
    required this.httpManager,
  });

  @override
  Future<String> login({
    required String username,
    required String password,
  }) async {
    final result = await httpManager.restRequest(
      url: ApiPaths.authUrl,
      method: HttpMethods.post,
      body: {
        "username": username,
        "password": password,
      },
    );
    if (result.containsKey('token')) {
      return result['token'];
    }
    throw Failure.fromMap(result);
  }
}
