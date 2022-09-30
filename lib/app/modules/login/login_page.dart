import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_seventh/app/modules/login/login_store.dart';
import 'package:teste_seventh/app/modules/login/widgets/custom_text_field.dart';
import 'package:teste_seventh/app/shared/config/failure.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _userNameController = TextEditingController();

  final _passwordController = TextEditingController();

  final _store = Modular.get<LoginStore>();

  void submit() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      try {
        await _store.signIn(
          username: _userNameController.text,
          password: _passwordController.text,
        );
      } on Failure catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent.shade200,
            content: const Text(
              'Erro ao realizar o login',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            duration: const Duration(
              seconds: 3,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 40,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Center(
                    child: Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue.shade800,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Observer(
                  builder: (_) {
                    return IgnorePointer(
                      ignoring: _store.isLoading,
                      child: CutomTextField(
                        icon: Icons.email,
                        label: 'Username',
                        validator: (username) {
                          if (username == null || username.isEmpty) {
                            return 'Digite seu username!';
                          }
                          if (username.length < 3) {
                            return 'Username inválido';
                          }
                          return null;
                        },
                        controller: _userNameController,
                      ),
                    );
                  },
                ),
                Observer(
                  builder: (_) {
                    return IgnorePointer(
                      ignoring: _store.isLoading,
                      child: CutomTextField(
                        icon: Icons.lock,
                        label: 'Senha',
                        isObscure: true,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return 'Digite sua senha!';
                          }
                          if (password.length < 5) {
                            return 'Senha inválida';
                          }
                          return null;
                        },
                        controller: _passwordController,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 50,
                  child: Observer(
                    builder: (_) {
                      return ElevatedButton(
                        onPressed: _store.isLoading ? null : submit,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          // primary: Colors.green,
                        ),
                        child: _store.isLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Entrar',
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
