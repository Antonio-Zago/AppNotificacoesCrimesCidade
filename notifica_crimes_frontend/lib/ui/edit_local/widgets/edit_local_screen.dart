import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';
import 'package:notifica_crimes_frontend/domain/models/local/local.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/button_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/circular_progress_indicator_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/text_form_field_default.dart';
import 'package:notifica_crimes_frontend/ui/edit_local/view_model/edit_local_view_model.dart';

class EditLocalScreen extends StatefulWidget {
  const EditLocalScreen({super.key, required this.viewModel});

  final EditLocalViewModel viewModel;

  @override
  State<EditLocalScreen> createState() => _EditLocalScreenState();
}

class _EditLocalScreenState extends State<EditLocalScreen> {
  @override
  Widget build(BuildContext context) {

    final local = ModalRoute.of(context)!.settings.arguments as Local;

    if(widget.viewModel.nomeController.text .isEmpty){
      widget.viewModel.nomeController.text = local.nome;
    }

    if(widget.viewModel.localizacaoController.text.isEmpty){
      widget.viewModel.localizacaoController.text = "Latitude: ${local.latitude} - Longitude: ${local.longitude} ";
    }
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(ColorsConstants.azulPadraoApp),
        iconTheme: IconThemeData(
          color: Colors.white, // Cor da setinha
        ),
        title: Text(
          "Editar local",
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
                            TextFormFieldDefault(
                              controller: widget.viewModel.nomeController,
                              mensagemValidacao:
                                  "Necessário preencher o nome do local",
                              label: "Nome",
                            ),

                            Padding(
                              padding: EdgeInsetsGeometry.only(top: 40),
                              child: ButtonDefault(
                                onPressed: () async {
                                  widget.viewModel.onTapButtonChoseLocation(
                                    context,
                                  );
                                },
                                label:
                                    widget
                                        .viewModel
                                        .localizacaoController
                                        .text
                                        .isEmpty
                                    ? "Escolher localização"
                                    : "Editar localização",
                                icon: Icons.map,
                                backgroundColor: Color(
                                  ColorsConstants.azulPadraoApp,
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsetsGeometry.only(top: 10),
                              child: TextFormField(
                                enabled: false,
                                controller:
                                    widget.viewModel.localizacaoController,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: Color(
                                        ColorsConstants.azulPadraoApp,
                                      ),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: Color(
                                        ColorsConstants.azulPadraoApp,
                                      ),
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: Colors
                                          .redAccent, // Cor da borda quando há erro
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      width: 1.5,
                                      color: Colors
                                          .redAccent, // Borda vermelha quando focado com erro
                                    ),
                                  ),
                                  errorStyle: TextStyle(
                                    color: Colors.red[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                                validator: (valor) {
                                  if (valor == null || valor.isEmpty) {
                                    return 'Selecione uma localização';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            Padding(
                              padding: EdgeInsetsGeometry.only(top: 40),
                              child: ButtonDefault(
                                onPressed: () async {
                                  var foiSalvo = await widget.viewModel
                                      .saveLocal(local.id);

                                  // Verifica se o widget ainda está montado (evita erro se a tela for fechada antes)
                                  if (!context.mounted) return;

                                  if (foiSalvo) {
                                    // Mostra mensagem de sucesso
                                    showDialog(
                                      context: context,
                                      builder: (dialogContext) => AlertDialog(
                                        title: const Text('Sucesso'),
                                        content: const Text(
                                          'Ocorrência salva com sucesso!',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(dialogContext).pop();

                                              Navigator.of(context).pop(true);
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