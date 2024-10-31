import 'package:flutter/material.dart';

import '../../core/components/button_widget.dart';
import '../../core/components/input_widget.dart';
import '../../core/constants/colors_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  bool mostrarSenha = true;

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
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 10),
                          child: Text(
                            'Faça Login',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF434343),
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              InputWidget(
                                labelInput: 'Email',
                                entradaController: emailController,
                                entradaTipo: TextInputType.emailAddress,
                                mostrarSenha: mostrarSenha,
                                prefixIcon: const Icon(Icons.email_outlined),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 25),
                                child: InputWidget(
                                  labelInput: 'Senha',
                                  entradaController: senhaController,
                                  entradaTipo: TextInputType.visiblePassword,
                                  mostrarSenha: mostrarSenha,
                                  prefixIcon:
                                      const Icon(Icons.lock_outline_rounded),
                                  sufixIcon: mostrarSenha
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  onPressIconSufix: () {
                                    setState(() {
                                      mostrarSenha = !mostrarSenha;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        ButtonWidget(
                          size: size,
                          onPressed: () {
                            Navigator.popAndPushNamed(context, '/home_page');
                          },
                          textoButton: 'Entrar',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: size.width * 0.26,
                                height: 1,
                                color: Colors.grey,
                              ),
                              const Text(
                                'Ou se preferir',
                                style: TextStyle(
                                    color: ColorConstants.cinzaTextColor),
                              ),
                              Container(
                                width: size.width * 0.26,
                                height: 1,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.07,
                          width: size.width,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              alignment: Alignment.centerLeft,
                            ),
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/images/icons/logo_google.png',
                              width: size.width * 0.1,
                            ),
                            label: const Text(
                              'Entrar com o Google',
                              style: TextStyle(color: Color(0xFF656565)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
