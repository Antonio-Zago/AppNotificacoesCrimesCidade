import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/button_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/circular_progress_indicator_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/text_form_field_default.dart';
import 'package:notifica_crimes_frontend/ui/edit_usuario/view_model/edit_usuario_view_model.dart';

class EditUsuarioScreen extends StatefulWidget {
  const EditUsuarioScreen({super.key, required this.viewModel});

  final EditUsuarioViewModel viewModel;

  @override
  State<EditUsuarioScreen> createState() => _EditUsuarioScreenState();
}

class _EditUsuarioScreenState extends State<EditUsuarioScreen> {

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
          "Editar perfil",
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
                            CircleAvatar(
                              radius: 40,
                            
                              backgroundImage: widget.viewModel.foto != null ?
                              MemoryImage(
                                widget.viewModel.foto!
                              ) : AssetImage(
                                 'assets/images/perfil_exemplo.png',
                               )
                            ),

                            Padding(
                              padding: EdgeInsetsGeometry.only(top: 40),
                              child: ButtonDefault(
                                onPressed: () async {
                                  _showOpcoesBottomSheet();
                                },
                                label: "Editar foto de perfil",
                                icon: Icons.edit,
                                backgroundColor: Color(
                                  ColorsConstants.azulPadraoApp,
                                ),
                              ),
                            ),

                            TextFormFieldDefault(
                              controller:
                                  widget.viewModel.nomeUsuarioController,
                              mensagemValidacao:
                                  "Necessário preencher o nome do usuário",
                              label: "Nome do usuário",
                            ),

                            Padding(
                              padding: EdgeInsetsGeometry.only(top: 40),
                              child: ButtonDefault(
                                onPressed: () async {
                                  var foiSalvo = await widget.viewModel
                                      .savePerfil();

                                  // Verifica se o widget ainda está montado (evita erro se a tela for fechada antes)
                                  if (!context.mounted) return;

                                  if (foiSalvo) {
                                    // Mostra mensagem de sucesso
                                    showDialog(
                                      context: context,
                                      builder: (dialogContext) => AlertDialog(
                                        title: const Text('Sucesso'),
                                        content: const Text(
                                          'Alterações salvas com sucesso!',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(dialogContext);

                                              Navigator.pushReplacementNamed(
                                                context,
                                                '/',
                                              );
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

   void _showOpcoesBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.photo_library,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Galeria',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () async {
                  Navigator.of(context).pop();
                  // Buscar imagem da galeria
                  await widget.viewModel.pegarFotoGaleria(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.photo_camera,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Câmera',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () async{
                  Navigator.of(context).pop();
                  // Fazer foto da câmera
                  await widget.viewModel.pegarFotoGaleria(ImageSource.camera);
                },
              ),
              
            ],
          ),
        );
      },
    );
  }
}
