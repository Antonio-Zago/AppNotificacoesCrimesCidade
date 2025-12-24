import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';
import 'package:notifica_crimes_frontend/ui/configuracoes/view_model/configuracoes_view_model.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/button_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/circular_progress_indicator_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/dropdown_button_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/text_form_field_default.dart';

class ConfiguracoesScreen extends StatefulWidget {
  const ConfiguracoesScreen({super.key, required this.viewModel});

  final ConfiguracoesViewModel viewModel;

  @override
  State<ConfiguracoesScreen> createState() => _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {

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
    widget.viewModel.initState();
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
          "Configurações",
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
            child: widget.viewModel.carregandoTela
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
                            DropdownButtonDefault(
                              onChanged:
                                  widget.viewModel.onChangedButtonNotificaLocalizacao,
                              valorSelecionado: widget.viewModel.notificaLocalizacao,
                              opcoes: [
                                DropdownMenuItem(
                                  value: 'N',
                                  child: Text('Não'),
                                ),
                                DropdownMenuItem(
                                  value: 'S',
                                  child: Text('Sim'),
                                ),
                              ],
                              titulo: "Notifica perto da minha localização",
                            ),
                            if (widget.viewModel.notificaLocalizacao != null &&
                                widget.viewModel.notificaLocalizacao == "S")
                              TextFormFieldDefault(
                                controller: widget
                                    .viewModel
                                    .notificaLocalizacaoDistanciaController,
                                mensagemValidacao:
                                    "Necessário preencher a distância",
                                label: "Distância localização",
                              ),

                            DropdownButtonDefault(
                              onChanged:
                                  widget.viewModel.onChangedButtonNotificaLocal,
                              valorSelecionado: widget.viewModel.notificaLocal,
                              opcoes: [
                                DropdownMenuItem(
                                  value: 'N',
                                  child: Text('Não'),
                                ),
                                DropdownMenuItem(
                                  value: 'S',
                                  child: Text('Sim'),
                                ),
                              ],
                              titulo: "Notifica perto locais salvos",
                            ),
                            if (widget.viewModel.notificaLocal != null &&
                                widget.viewModel.notificaLocal == "S")
                              TextFormFieldDefault(
                                controller: widget
                                    .viewModel
                                    .notificaLocalDistanciaController,
                                mensagemValidacao:
                                    "Necessário preencher a distância",
                                label: "Distância local",
                              ),

                            Padding(
                              padding: EdgeInsetsGeometry.only(top: 40),
                              child: ButtonDefault(
                                onPressed: () async {
                                  var foiSalvo = await widget.viewModel
                                      .saveConfiguracoes();

                                  // Verifica se o widget ainda está montado (evita erro se a tela for fechada antes)
                                  if (!context.mounted) return;

                                  if (foiSalvo) {
                                    // Mostra mensagem de sucesso
                                    showDialog(
                                      context: context,
                                      builder: (dialogContext) => AlertDialog(
                                        title: const Text('Sucesso'),
                                        content: const Text(
                                          'Configurações salvas com sucesso!',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(dialogContext);
                                            },
                                                
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                                label: "Salvar",
                                icon: Icons.save,
                                backgroundColor: Color(
                                  ColorsConstants.verdeBotaoSalvar,
                                ),
                              ),
                            ),

                             Padding(
                              padding: EdgeInsetsGeometry.only(top: 40),
                              child: ButtonDefault(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context,
                                      '/edit-perfil',
                                    );
                                },
                                label: "Editar perfil",
                                icon: Icons.edit,
                                backgroundColor: Color(
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
