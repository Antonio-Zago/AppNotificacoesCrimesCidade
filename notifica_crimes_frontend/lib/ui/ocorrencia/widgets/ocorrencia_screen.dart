import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/button_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/circular_progress_indicator_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/drawer_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/dropdown_button_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/text_form_field_data_hora.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/text_form_field_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/text_form_field_descricao.dart';
import 'package:notifica_crimes_frontend/ui/ocorrencia/view_model/ocorrencia_view_model.dart';

class OcorrenciaScreen extends StatefulWidget {
  const OcorrenciaScreen({super.key, required this.viewModel});

  final OcorrenciaViewModel viewModel;

  @override
  State<OcorrenciaScreen> createState() => _OcorrenciaScreenState();
}

class _OcorrenciaScreenState extends State<OcorrenciaScreen> {
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
    Future.microtask(() {
      widget.viewModel.initState();
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
          "Nova ocorrência",
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
                              onChanged: widget.viewModel.onChangedButtonTipo,
                              valorSelecionado: widget.viewModel.tipo,
                              opcoes: [
                                DropdownMenuItem(
                                  value: 'F',
                                  child: Text('Furto'),
                                ),
                                DropdownMenuItem(
                                  value: 'R',
                                  child: Text('Roubo'),
                                ),
                                DropdownMenuItem(
                                  value: 'A',
                                  child: Text('Agressão'),
                                ),
                                DropdownMenuItem(
                                  value: 'O',
                                  child: Text('Outro'),
                                ),
                              ],
                              titulo: "Tipo",
                            ),
                            if (widget.viewModel.tipo != null)
                              TextFormFieldDataHora(
                                controller: widget.viewModel.dateController,
                                onTap: () async {
                                  await widget.viewModel.selectDate(context);
                                },
                                mensagemValidacao:
                                    "Necessário preencher a data e hora",
                              ),

                            if (widget.viewModel.tipo != null)
                              TextFormFieldDescricao(
                                controller:
                                    widget.viewModel.descricaoController,
                                mensagemValidacao:
                                    "Necessário preencher o campo descrição",
                              ),

                            if (widget.viewModel.tipo != null &&
                                (widget.viewModel.tipo == "R" ||
                                    widget.viewModel.tipo == "A"))
                              TextFormFieldDefault(
                                controller:
                                    widget.viewModel.numeroAgressoresController,
                                mensagemValidacao:
                                    "Necessário preencher a quantidade de agressores",
                              ),

                            if (widget.viewModel.tipo != null &&
                                (widget.viewModel.tipo == "R" ))
                              DropdownButtonDefault(
                                onChanged: widget
                                    .viewModel
                                    .onChangedButtonEstavaArmado,
                                valorSelecionado: widget.viewModel.estavaArmado,
                                opcoes: [
                                  DropdownMenuItem(
                                    value: 'S',
                                    child: Text('Sim'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'N',
                                    child: Text('Não'),
                                  ),
                                ],
                                titulo: "Estava armado?",
                              ),

                            if (widget.viewModel.tipo != null &&
                                (widget.viewModel.tipo == "R" ||
                                    widget.viewModel.tipo == "A") &&
                                widget.viewModel.estavaArmado == "S")
                              DropdownButtonDefault(
                                onChanged:
                                    widget.viewModel.onChangedButtonTipoArma,
                                valorSelecionado: widget.viewModel.tipoArma,
                                opcoes: widget.viewModel.tipoArmas
                                    .map(
                                      (arma) => DropdownMenuItem(
                                        value: arma.id.toString(),
                                        child: Text(arma.nome),
                                      ),
                                    )
                                    .toList(),
                                titulo: "Tipo de arma",
                              ),

                            if (widget.viewModel.tipo != null &&
                                widget.viewModel.tipo == "A")
                              DropdownButtonDefault(
                                onChanged: widget
                                    .viewModel
                                    .onChangedButtonTipoAgressao,
                                valorSelecionado: widget.viewModel.tipoAgressao,
                                opcoes: [
                                  DropdownMenuItem(
                                    value: 'F',
                                    child: Text('Fisica'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'V',
                                    child: Text('Verbal'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'A',
                                    child: Text('Ambas'),
                                  ),
                                ],
                                titulo: "Tipo de agressão",
                              ),

                            if (widget.viewModel.tipo != null)
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

                            if (widget.viewModel.tipo != null)
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
                            if (widget.viewModel.tipo != null &&
                                (widget.viewModel.tipo == "R" ||
                                    widget.viewModel.tipo == "F"))
                              Padding(
                                padding: EdgeInsetsGeometry.only(top: 40),
                                child: ButtonDefault(
                                  onPressed: () async {
                                    await widget.viewModel.onTapButtonChoseBens(
                                      context,
                                    );
                                  },
                                  label:
                                      widget.viewModel.bensSelecionados.isEmpty
                                      ? "Escolher bens levados"
                                      : "Editar bens selecionados",
                                  icon:
                                      widget.viewModel.bensSelecionados.isEmpty
                                      ? Icons.add_box
                                      : Icons.edit,
                                  backgroundColor: Color(
                                    ColorsConstants.azulPadraoApp,
                                  ),
                                ),
                              ),
                            if (widget.viewModel.tipo != null)
                              Padding(
                                padding: EdgeInsetsGeometry.only(top: 40),
                                child: ButtonDefault(
                                  onPressed: () async {
                                    var foiSalvo = await widget.viewModel
                                        .saveOcorrencia();

                                    // Verifica se o widget ainda está montado (evita erro se a tela for fechada antes)
                                    if (!context.mounted) return;

                                    if (foiSalvo) {
                                      // Mostra mensagem de sucesso
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Sucesso'),
                                          content: const Text(
                                            'Ocorrência salva com sucesso!',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
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
