import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/button/button_controller.dart';
import '../../../../core/components/button/button_widget.dart';
import '../../../../core/components/input_widget.dart';
import '../../../../core/components/snackbar/snackbar_mixin.dart';
import '../../../../core/constants/colors_constants.dart';
import '../../../../core/utils/session/user_session.dart';
import '../../data/models/user_model.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with SnackbarMixin {
  bool showPassword = true;

  late LoginController loginController;

  ValueNotifier<bool> createAccount = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    loginController = Provider.of<LoginController>(context, listen: false);
    loginController.loginState.addListener(() => _listenerLoginState());
  }

  @override
  void dispose() {
    loginController.emailController.text = '';
    loginController.passwordController.text = '';

    loginController.buttonController.changeState(ButtonStateEnum.disabled);
    loginController.loginState.removeListener(() => _listenerLoginState());

    super.dispose();
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
              ValueListenableBuilder(
                valueListenable: createAccount,
                builder: (_, value, __) {
                  final isLargeDevice = size.height > 710;
                  return Positioned(
                    top: isLargeDevice || !value
                        ? size.height * 0.5
                        : value
                            ? size.height * 0.4
                            : size.height * 0.3,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: size.height * 0.8,
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
                                createAccount.value = value == 1;
                                loginController.verifyForm(createAccount.value);
                              },
                              unselectedLabelColor: Colors.grey,
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  _buildForm(size, true),
                                  _buildForm(size, false),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(Size size, bool isLogin) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              isLogin ? 'Faça Login' : 'Criar Conta',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color(0xFF434343),
              ),
            ),
          ),
          Column(
            children: [
              if (!isLogin)
                _buildInputField(
                  'Nome',
                  loginController.nameController,
                  TextInputType.name,
                ),
              _buildInputField(
                'Email',
                loginController.emailController,
                TextInputType.emailAddress,
              ),
              _buildInputField(
                'Senha',
                loginController.passwordController,
                TextInputType.visiblePassword,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Visibility(
              visible: isLogin,
              child: _buildGenericButton('Entrar', () async {
                return await loginController.login(
                  loginController.emailController.text,
                  loginController.passwordController.text,
                );
              }, isLogin),
              replacement: _buildGenericButton('Criar Conta', () async {
                return await loginController.register(
                  loginController.emailController.text,
                  loginController.passwordController.text,
                  loginController.nameController.text,
                );
              }, isLogin),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller,
    TextInputType keyboardType,
  ) {
    return Column(
      children: [
        InputWidget(
          labelInput: label,
          controller: controller,
          keyboardType: keyboardType,
          onChanged: (p0) => loginController.verifyForm(createAccount.value),
          prefixIcon: label == 'Nome'
              ? const Icon(Icons.person_outline)
              : const Icon(Icons.email_outlined),
          showPassword: keyboardType == TextInputType.visiblePassword
              ? showPassword
              : null,
          sufixIcon: keyboardType == TextInputType.visiblePassword
              ? (showPassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined)
              : null,
          onPressIconSufix: keyboardType == TextInputType.visiblePassword
              ? () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                }
              : null,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildGenericButton(
    String text,
    Future<String?> Function() onPressedAction,
    bool isLogin,
  ) {
    return ValueListenableBuilder(
      valueListenable: loginController.buttonController.buttonState,
      builder: (_, buttonState, __) {
        return ButtonWidget(
          textButton: text,
          buttonState: buttonState,
          backgroundColor: AppColors.primary,
          onPressed: () async {
            final uuid = await onPressedAction();

            if (uuid == null) {
              _setErroInButton();
              return;
            }
            if (!mounted) {
              return;
            }

            await loginController.saveToken(uuid);
            final sessionUser = Provider.of<UserSession>(
              context,
              listen: false,
            );

            UserModel? user;
            if (isLogin) {
              user = await loginController.getUser(uuid);
            } else {
              user = UserModel(
                uid: uuid,
                email: loginController.emailController.text,
                name: loginController.nameController.text,
              );

              await loginController.saveUser(user);
            }

            sessionUser.setUser(user);

            Navigator.popAndPushNamed(context, '/home_page');
          },
        );
      },
    );
  }

  void _setErroInButton() {
    loginController.buttonController.changeState(ButtonStateEnum.error);
    Future.delayed(const Duration(seconds: 1)).whenComplete(() {
      loginController.buttonController.changeState(ButtonStateEnum.enabled);
    });
  }

  void _listenerLoginState() {
    if (!mounted) return; // Verifica se o widget ainda está montado
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
  }
}
