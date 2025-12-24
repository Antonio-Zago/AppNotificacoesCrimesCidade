import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notifica_crimes_frontend/data/repositories/configuracoes/configuracoes_repository.dart';

class EditUsuarioViewModel extends ChangeNotifier {
  EditUsuarioViewModel({
    required this.configuracoesRepository,
    required this.storage,
  });

  final ConfiguracoesRepository configuracoesRepository;
  final FlutterSecureStorage storage;

  bool carregandoTela = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController nomeUsuarioController = TextEditingController();
  Exception? error;
  Uint8List? foto;
  final ImagePicker _picker = ImagePicker();

  Future<void> initState() async {
    try {
      carregandoTela = true;
      notifyListeners();

      var nomeUsuario = (await storage.read(key: "usuario"))!;

      nomeUsuarioController.text = nomeUsuario;

      var fotoSalva = await storage.read(key: "foto");

      if (fotoSalva != null) {
        foto = base64ToBytes(fotoSalva);
      }

      carregandoTela = false;
      notifyListeners();
    } on Exception catch (exception) {
      error = exception;
      carregandoTela = false;
    } finally {
      notifyListeners();
    }
  }

  Future<void> pegarFotoGaleria(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 70, // reduz tamanho
    );

    if (image == null) return null;

    foto = await image.readAsBytes();

    notifyListeners();
  }

  Uint8List base64ToBytes(String base64) {
    return base64Decode(base64.split(',').last);
  }

  String uint8ListToBase64(Uint8List bytes) {
    return base64Encode(bytes);
  }

  Future<bool> savePerfil() async {
    carregandoTela = true;
    notifyListeners();
    try {
      if (formKey.currentState!.validate()) {
        String fotoBase64 = "";

        if (foto != null) {
          fotoBase64 = uint8ListToBase64(foto!);
        }

        var result = await configuracoesRepository.putPerfil(
          nomeUsuarioController.text,
          fotoBase64,
        );

        await storage.write(key: "foto", value: fotoBase64);
        await storage.write(key: "usuario", value: nomeUsuarioController.text);

        result.getOrThrow();



        carregandoTela = false;
        notifyListeners();

        return true;
      }

      carregandoTela = false;
      notifyListeners();
      return false;
    } on Exception catch (exception) {
      error = exception;
      carregandoTela = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    error = null;
  }
}
