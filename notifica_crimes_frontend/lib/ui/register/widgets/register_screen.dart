import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/button_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/button_small_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/circular_progress_indicator_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/text_form_field_login_cadastro.dart';
import 'package:notifica_crimes_frontend/ui/register/view_model/register_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.viewModel});

  final RegisterViewModel viewModel;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController controllerUsuario = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerSenha = TextEditingController();
  final TextEditingController controllerRepitaSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (BuildContext context, _) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_login.png'),
                fit: BoxFit.cover, // cobre toda a tela
              ),
            ),
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsGeometry.only(top: 40),
                child: Column(
                  children: [
                    Image.asset("assets/images/logo.png", width: 180),
                    Padding(
                      padding: EdgeInsetsGeometry.only(top: 50),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: BoxBorder.all(
                            color: Color.fromARGB(20, 0, 0, 0),
                            width: 4,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsGeometry.only(
                            left: 15,
                            right: 15,
                            top: 80,
                            bottom: 15,
                          ),
                          child: Form(
                            child: Column(
                              children: [
                                TextFormFieldLoginCadastro(
                                  label: "Usuário",
                                  prefixIcon: Icon(Icons.person),
                                  controller: controllerUsuario,
                                  enabled: !widget.viewModel.carregando,
                                ),
                                Padding(
                                  padding: EdgeInsetsGeometry.only(top: 25),
                                  child: TextFormFieldLoginCadastro(
                                    label: "Email",
                                    prefixIcon: Icon(Icons.email),
                                    controller: controllerEmail,
                                    enabled: !widget.viewModel.carregando,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsGeometry.only(top: 25),
                                  child: TextFormFieldLoginCadastro(
                                    label: "Senha",
                                    prefixIcon: Icon(Icons.lock),
                                    controller: controllerSenha,
                                    password: true,
                                    enabled: !widget.viewModel.carregando,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsGeometry.only(top: 25),
                                  child: TextFormFieldLoginCadastro(
                                    label: "Repita a senha",
                                    prefixIcon: Icon(Icons.lock),
                                    controller: controllerRepitaSenha,
                                    password: true,
                                    enabled: !widget.viewModel.carregando,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsGeometry.only(
                                    top: 5,
                                    left: 15,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      "Esqueceu sua senha?",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsGeometry.only(top: 50),
                                  child: widget.viewModel.carregando
                                      ? CircularProgressIndicatorDefault()
                                      : Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsGeometry.only(
                                                top: 15,
                                              ),
                                              child: ButtonDefault(
                                                onPressed: widget
                                                    .viewModel
                                                    .onPressedButtonRegister,
                                                label: "Criar conta",
                                                icon: Icons.person_add,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsGeometry.only(
                                                top: 25,
                                              ),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: ButtonSmallDefault(
                                                  icon: Icons.arrow_back,
                                                  label: "Voltar ao login",
                                                  onPressed: () => widget
                                                    .viewModel
                                                    .onPressedButtonReturn(context),
                                                )
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
