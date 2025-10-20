import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/bens.dart';
import 'package:notifica_crimes_frontend/ui/choose_bens/view_model/choose_bens_view_model.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/button_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/circular_progress_indicator_default.dart';

class ChooseBensScreen extends StatefulWidget {
  const ChooseBensScreen({super.key, required this.viewModel});

  final ChooseBensViewModel viewModel;

  @override
  State<ChooseBensScreen> createState() => _ChooseBensScreenState();
}

class _ChooseBensScreenState extends State<ChooseBensScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
    final bensSelecionados =
        ModalRoute.of(context)!.settings.arguments as List<Bens>?;

    widget.viewModel.initState(bensSelecionados);

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
          "Escolha os tipos de bens levados",
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
          return widget.viewModel.carregandoTela
              ? Center(
                  child: SizedBox(
                    width: 80, // tamanho personalizado
                    height: 80,
                    child: CircularProgressIndicatorDefault(),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.viewModel.bens.length,
                        itemBuilder: (context, index) {
                          final bem = widget.viewModel.bens[index];
                          final selecionado = widget.viewModel.selecionados
                              .contains(index);

                          return InkWell(
                            onTap: () {
                              widget.viewModel.onTapOption(index);
                            },
                            child: Container(
                              color: selecionado
                                  ? Colors.blue.withOpacity(0.3)
                                  : (index % 2 == 0
                                        ? Colors.grey.shade200
                                        : Colors.white), // linhas alternadas
                              child: ListTile(
                                title: Text(bem.nome),
                                trailing: selecionado
                                    ? const Icon(
                                        Icons.check_circle,
                                        color: Colors.blue,
                                      )
                                    : const Icon(Icons.circle_outlined),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ButtonDefault(
                          onPressed: () {
                            widget.viewModel.onTapConfirmOptions(context);
                          },
                          label: "Confirmar seleção",
                          icon: Icons.save,
                          backgroundColor: Color(
                            ColorsConstants.verdeBotaoSalvar,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
