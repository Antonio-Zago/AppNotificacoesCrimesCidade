import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/data/repositories/ocorrencias/ocorrencia_repository.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/bens.dart';

class ChooseBensViewModel extends ChangeNotifier {
  ChooseBensViewModel({required this.ocorrenciaRepository});

  final OcorrenciaRepository ocorrenciaRepository;

  bool carregandoTela = false;
  List<Bens> bens = [];
  Exception? error;
  final Set<int> selecionados = {}; // índices dos itens selecionados

  Future<void> initState(List<Bens>? bensSelecionados) async {
    try {
      carregandoTela = true;
      notifyListeners();
      var bensApi = await ocorrenciaRepository.findAllBens();

      bens = bensApi.getOrThrow();

      if (bensSelecionados != null) {
        _marcarSelecionados(bensSelecionados);
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

  void onTapOption(int index) {
    final selecionado = selecionados.contains(index);

    if (selecionado) {
      selecionados.remove(index);
    } else {
      selecionados.add(index);
    }

    notifyListeners();
  }

  void onTapConfirmOptions(BuildContext context) {
    List<Bens> bensSelecionados = [
      for (int i = 0; i < bens.length; i++)
        if (selecionados.contains(i)) bens[i],
    ];
    Navigator.pop(context, bensSelecionados);
  }

  void _marcarSelecionados(List<Bens> selecionados) {
  for (int i = 0; i < bens.length; i++) {
    if (selecionados.any((b) => b.id == bens[i].id)) {
      this.selecionados.add(i);
    }
  }
}
}
