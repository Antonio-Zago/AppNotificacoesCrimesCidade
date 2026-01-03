import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/button_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/button_small_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/circular_progress_indicator_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/text_form_field_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/text_form_field_login_cadastro.dart';
import 'package:notifica_crimes_frontend/ui/validacao_email/view_model/validacao_email_view_model.dart';

class ValidacaoEmailScreen extends StatefulWidget {
  const ValidacaoEmailScreen({super.key, required this.viewModel});

  final ValidacaoEmailViewModel viewModel;

  @override
  State<ValidacaoEmailScreen> createState() => _ValidacaoEmailScreenState();
}

class _ValidacaoEmailScreenState extends State<ValidacaoEmailScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(() {
      final error = widget.viewModel.error;
      if (error != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              backgroundColor: Colors.redAccent,
            ),
          );
          widget.viewModel.clearError(); // limpa depois que mostrar
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(ColorsConstants.azulPadraoApp),
        iconTheme: IconThemeData(
          color: Colors.white, // Cor da setinha
        ),
        title: Text(
          "Validação email",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (BuildContext context, _) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/background.png',
                ), // Path to your image
                fit: BoxFit
                    .cover, // How the image should fit within the container
              ),
            ),
            child: widget.viewModel.carregando
                ? Center(
                    child: SizedBox(
                      width: 80, // tamanho personalizado
                      height: 80,
                      child: CircularProgressIndicatorDefault(),
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(35),
                      child: Form(
                        key: widget.viewModel.formKey,
                        child: Column(
                          children: [
                            Text(
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              "Um código foi enviado ao e-mail cadastrado, copie e cole abaixo para validação",
                            ),

                            Padding(
                              padding: EdgeInsetsGeometry.only(top: 10),
                              child: TextFormFieldDefault(
                                controller: widget.viewModel.controllerCodigo,
                                mensagemValidacao:
                                    "Necessário preencher a distância",
                                label: "Código validação email",
                              ),
                            ),

                            Padding(
                              padding: EdgeInsetsGeometry.only(top: 40),
                              child: ButtonDefault(
                                onPressed: () async {
                                  var validou = await widget.viewModel
                                      .onPressedButtonValidar();

                                  // Verifica se o widget ainda está montado (evita erro se a tela for fechada antes)
                                  if (!context.mounted) return;

                                  if (validou) {
                                    // Mostra mensagem de sucesso
                                    showDialog(
                                      context: context,
                                      builder: (dialogContext) => AlertDialog(
                                        title: const Text('Sucesso'),
                                        content: const Text(
                                          'Validação feita com sucesso!',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(dialogContext);
                                              Navigator.pushReplacementNamed(
                                                context,
                                                "/home",
                                              );
                                            },

                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                                label: "Validar",
                                icon: Icons.arrow_circle_right,
                                backgroundColor: Color(
                                  ColorsConstants.verdeBotaoSalvar,
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsetsGeometry.only(top: 40),
                              child: ButtonDefault(
                                onPressed: widget.viewModel.botaoDesabilitado
                                    ? null
                                    : () async {
                                        var validou = await widget.viewModel
                                            .onPressedButtonReenviar();

                                        // Verifica se o widget ainda está montado (evita erro se a tela for fechada antes)
                                        if (!context.mounted) return;

                                        if (validou) {
                                          
                                          widget.viewModel.iniciarTimer();

                                          showDialog(
                                            context: context,
                                            builder: (dialogContext) => AlertDialog(
                                              title: const Text('Sucesso'),
                                              content: const Text(
                                                'Reenvio feito com sucesso!',
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                      dialogContext,
                                                    );
                                                  },

                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                label: widget.viewModel.botaoDesabilitado ? 'Aguarde ${widget.viewModel.formatarTempo()}' : "Reenviar código",
                                icon: Icons.arrow_circle_right,
                                backgroundColor: widget.viewModel.botaoDesabilitado ? Colors.grey :Color(
                                  ColorsConstants.azulPadraoApp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
