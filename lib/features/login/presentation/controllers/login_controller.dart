import 'package:flutter/material.dart';

import '../../../../core/components/button/button_controller.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/auth_repository.dart';

class LoginController extends ChangeNotifier {
  final AuthRepository _authRepository;
  final loginState = ValueNotifier(LoginState.initial);

  String messageError = '';
  String token = '';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final buttonController = ButtonController();

  LoginController(this._authRepository);

  Future<String?> login(String email, String password) async {
    loginState.value = LoginState.loading;
    final token = await _authRepository.login(email, password);

    if (token.$1 == null && token.$2 != null) {
      if (token.$2 is UserNotFoundFailure) {
        messageError = 'Não foi encontrado usuário com este e-mail!';
      } else if (token.$2 is WrongPasswordFailure) {
        messageError = 'Sua senha ou e-mail estão incorretos!';
      } else {
        messageError = 'Ops, ocorreu um erro! Tente novamente.';
      }
      loginState.value = LoginState.error;

      return null;
    }

    loginState.value = LoginState.success;
    this.token = token.$1!;
    return token.$1;
  }

  void verifyForm(createAccount) {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      if (createAccount) {
        buttonController.changeState(
          nameController.text.isNotEmpty
              ? ButtonStateEnum.enabled
              : ButtonStateEnum.disabled,
        );
        return;
      }
      buttonController.changeState(ButtonStateEnum.enabled);
    } else {
      buttonController.changeState(ButtonStateEnum.disabled);
    }
  }
}

enum LoginState { initial, loading, success, error }
