import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/button/button_controller.dart';
import '../../../../core/components/button/button_widget.dart';
import '../../../../core/components/input_widget.dart';
import '../../../../core/components/snackbar/snackbar_mixin.dart';
import '../../../../core/constants/colors_constants.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with SnackbarMixin {
  bool showPassword = true;

  late LoginController loginController;

  bool createAccount = false;

  @override
  void initState() {
    super.initState();

    loginController = Provider.of<LoginController>(context, listen: false);

    loginController.emailController
        .addListener(() => loginController.verifyForm(createAccount));
    loginController.passwordController
        .addListener(() => loginController.verifyForm(createAccount));
    loginController.nameController
        .addListener(() => loginController.verifyForm(createAccount));
    loginController.loginState.addListener(() => _listenerLoginState());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              Image.asset('assets/images/mulher_01.png'),
              Positioned(
                top: size.height * 0.5,
                left: 0,
                right: 0,
                child: Container(
                  height: size.height * 0.55,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TabBar(
                          tabs: const [
                            Tab(text: 'Entrar'),
                            Tab(text: 'Criar Conta'),
                          ],
                          labelColor: Colors.black,
                          onTap: (value) {
                            createAccount = value == 1;
                            loginController.verifyForm(createAccount);
                          },
                          unselectedLabelColor: Colors.grey,
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              _buildLoginForm(size),
                              _buildSignUpForm(size),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Faça Login',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color(0xFF434343),
              ),
            ),
          ),
          Column(
            children: [
              InputWidget(
                labelInput: 'Email',
                controller: loginController.emailController,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(height: 16),
              InputWidget(
                labelInput: 'Senha',
                controller: loginController.passwordController,
                keyboardType: TextInputType.visiblePassword,
                showPassword: showPassword,
                prefixIcon: const Icon(
                  Icons.lock_outline_rounded,
                ),
                sufixIcon: showPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                onPressIconSufix: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 48),
          _buildLoginButton(),
        ],
      ),
    );
  }

  Widget _buildSignUpForm(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 15, bottom: 10),
            child: Text(
              'Criar Conta',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color(0xFF434343),
              ),
            ),
          ),
          Column(
            children: [
              InputWidget(
                labelInput: 'Nome',
                controller: loginController.nameController,
                keyboardType: TextInputType.name,
                prefixIcon: const Icon(Icons.person_outline),
              ),
              const SizedBox(height: 16),
              InputWidget(
                labelInput: 'Email',
                controller: loginController.emailController,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(height: 16),
              InputWidget(
                labelInput: 'Senha',
                controller: loginController.passwordController,
                keyboardType: TextInputType.visiblePassword,
                showPassword: showPassword,
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                sufixIcon: showPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                onPressIconSufix: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 48),
          _buildSignUpButton(),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return ValueListenableBuilder(
      valueListenable: loginController.buttonController.buttonState,
      builder: (_, buttonState, __) {
        return ButtonWidget(
          buttonState: buttonState,
          backgroundColor: AppColors.primary,
          onPressed: () async {
            loginController.buttonController
                .changeState(ButtonStateEnum.loading);
            final token = await loginController.login(
              loginController.emailController.text,
              loginController.passwordController.text,
            );

            if (token == null) {
              loginController.buttonController
                  .changeState(ButtonStateEnum.error);
              Future.delayed(const Duration(seconds: 1)).whenComplete(() {
                loginController.buttonController
                    .changeState(ButtonStateEnum.enabled);
              });
              return;
            }
            loginController.buttonController
                .changeState(ButtonStateEnum.success);
          },
          textButton: 'Entrar',
        );
      },
    );
  }

  Widget _buildSignUpButton() {
    return ValueListenableBuilder(
        valueListenable: loginController.buttonController.buttonState,
        builder: (_, buttonState, __) {
          return ButtonWidget(
            buttonState: buttonState,
            backgroundColor: AppColors.primary,
            onPressed: () async {
              loginController.buttonController
                  .changeState(ButtonStateEnum.loading);
              final token = await loginController.register(
                loginController.emailController.text,
                loginController.passwordController.text,
                loginController.nameController.text,
              );

              if (token == null) {
                loginController.buttonController
                    .changeState(ButtonStateEnum.error);
                Future.delayed(const Duration(seconds: 1)).whenComplete(() {
                  loginController.buttonController
                      .changeState(ButtonStateEnum.enabled);
                });
                return;
              }
              loginController.buttonController
                  .changeState(ButtonStateEnum.success);
              Future.delayed(const Duration(seconds: 1)).whenComplete(() {
                Navigator.popAndPushNamed(
                  context,
                  '/home_page',
                );
              });
            },
            textButton: 'Criar Conta',
          );
        });
  }

  void _listenerLoginState() {
    if (loginController.loginState.value == LoginState.error) {
      showSnackbarWithError(
        context: context,
        message: loginController.messageError,
        backgroundColor: const Color(0xFFD65745),
        buttonColor: Colors.red,
        buttonLabel: 'Fechar',
        fontColor: Colors.white,
      );
    }

    if (loginController.loginState.value == LoginState.success) {
      Future.delayed(const Duration(seconds: 1)).whenComplete(() {
        Navigator.popAndPushNamed(
          context,
          '/home_page',
        );
      });
    }
  }
}
