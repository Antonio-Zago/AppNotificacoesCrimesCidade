import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/button_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/circular_progress_indicator_default.dart';
import 'package:notifica_crimes_frontend/ui/locais/view_model/locais_view_model.dart';

class LocaisScreen extends StatefulWidget {
  const LocaisScreen({super.key, required this.viewModel});

  final LocaisViewModel viewModel;

  @override
  State<LocaisScreen> createState() => _LocaisScreenState();
}

class _LocaisScreenState extends State<LocaisScreen> {
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
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (BuildContext context, _) {
        if (widget.viewModel.carregandoTela) {
          return const Scaffold(
            body: Center(
              child: SizedBox(
                width: 80, // tamanho personalizado
                height: 80,
                child: CircularProgressIndicatorDefault(),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(ColorsConstants.azulPadraoApp),
            iconTheme: IconThemeData(
              color: Colors.white, // Cor da setinha
            ),
            title: Text(
              "Locais",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Container(
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
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsGeometry.all(35),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.viewModel.locais.length,
                      itemBuilder: (context, index) {
                        final local = widget.viewModel.locais[index];
                        final isEven = index % 2 == 0;

                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          color: isEven
                              ? Colors.grey.shade100
                              : Colors.blueGrey.shade50,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                // Nome
                                Expanded(
                                  child: Text(
                                    local.nome,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),

                                // Botão editar
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  tooltip: 'Editar',
                                  onPressed: () async {
                                    final resultado = await Navigator.pushNamed(
                                      context,
                                      '/edit-local',
                                      arguments: local
                                    );

                                    if (resultado == true) {
                                      await widget.viewModel.initState();
                                    }
                                  },
                                ),

                                // Botão excluir
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  tooltip: 'Excluir',
                                  onPressed: () async{
                                    var resultado = await widget.viewModel.excluirLocal(local.id);

                                    if (resultado) {
                                      await widget.viewModel.initState();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(35),
            child: ButtonDefault(
              onPressed: () async {
                final resultado = await Navigator.pushNamed(
                  context,
                  '/new-local',
                );

                if (resultado == true) {
                  await widget.viewModel.initState();
                }
              },
              label: "Novo",
              icon: Icons.add_circle,
              backgroundColor: Color(ColorsConstants.azulPadraoApp),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
