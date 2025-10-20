import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:notifica_crimes_frontend/data/repositories/ocorrencias/ocorrencia_repository.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/armas.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/bens.dart';

class OcorrenciaViewModel extends ChangeNotifier {
  OcorrenciaViewModel({required this.ocorrenciaRepository});

  final OcorrenciaRepository ocorrenciaRepository;

  TextEditingController dateController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController numeroAgressoresController = TextEditingController();
  TextEditingController localizacaoController = TextEditingController();
  DateTime? dataInicial;
  String? tipo;
  String? estavaArmado;
  String? tipoArma;
  String? tipoAgressao;
  bool carregandoTela = false;
  List<Armas> tipoArmas= [];
  Exception? error;
  List<Bens> bensSelecionados = [];
  final formKey = GlobalKey<FormState>();

  Future<void> initState() async {
    try{
      carregandoTela = true;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 5));
      var armas = await ocorrenciaRepository.findAllArmas();

      tipoArmas = armas.getOrThrow();

      carregandoTela = false;
      notifyListeners();
    }on Exception catch (exception) {
      error = exception;
      carregandoTela = false;
    }finally {
      notifyListeners();
    }
  }

  Future<void> saveOcorrencia() async {
    
    if (formKey.currentState!.validate()) {

    } else {
      
    }


  }

  Future<void> selectDate(BuildContext context) async {
    dataInicial ??= DateTime.now();

    final DateTime? data = await showDatePicker(
      context: context,
      initialDate: dataInicial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (data == null) return;

    if (!context.mounted) return;

    final TimeOfDay? hora = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(dataInicial!),
    );

    if (hora == null) return;

    dateController.text =
        "${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year} ${hora.hour.toString().padLeft(2, '0')}:${hora.minute.toString().padLeft(2, '0')}";
    dataInicial = DateTime(
      data.year,
      data.month,
      data.day,
      hora.hour,
      hora.minute,
    );
    notifyListeners();
  }

  void onChangedButtonTipo(String? valor) {
    tipo = valor;

    resetarControllers();
    notifyListeners();
  }

  void onChangedButtonEstavaArmado(String? valor) {
    estavaArmado = valor;
    notifyListeners();
  }

  void onChangedButtonTipoArma(String? valor) {
    tipoArma = valor;
    notifyListeners();
  }

  void onChangedButtonTipoAgressao(String? valor) {
    tipoAgressao = valor;
    notifyListeners();
  }

  void resetarControllers(){
    dateController.clear();
    descricaoController.clear();
    numeroAgressoresController.clear();
    estavaArmado = null;
    tipoArma = null;
    tipoAgressao = null;
    localizacaoController.clear();
    bensSelecionados.clear();
  }

  Future<void> onTapButtonChoseLocation(BuildContext context) async {
    final retornoLocalizacaoSelecionada = await Navigator.pushNamed(
      context,
      '/choose-location-map',
    );

    if (retornoLocalizacaoSelecionada is LatLng?) {
      if (retornoLocalizacaoSelecionada != null) {
        localizacaoController.text =
            "Latitude: ${retornoLocalizacaoSelecionada.latitude} - Longitude: ${retornoLocalizacaoSelecionada.longitude} ";
        notifyListeners();
      }
    }
  }

  Future<void> onTapButtonChoseBens(BuildContext context) async {
    final retornarBensSelecionados = await Navigator.pushNamed(
      context,
      '/choose-bens',
      arguments: bensSelecionados,
    );

    if (retornarBensSelecionados is List<Bens>) {
      bensSelecionados = retornarBensSelecionados;
      notifyListeners();
    }
  }
}
