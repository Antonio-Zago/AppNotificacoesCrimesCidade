import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:notifica_crimes_frontend/data/repositories/ocorrencias/ocorrencia_repository.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/agressao.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/armas.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/assalto.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/bens.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/localizacao_ocorrencia.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/ocorrencia.dart';
import 'package:notifica_crimes_frontend/domain/models/ocorrencias/roubo.dart';
import 'package:timezone/timezone.dart' as tz;

class OcorrenciaViewModel extends ChangeNotifier {
  OcorrenciaViewModel({required this.ocorrenciaRepository});

  final OcorrenciaRepository ocorrenciaRepository;

  TextEditingController dateController = TextEditingController();
  DateTime? dataSelecionada;
  TextEditingController descricaoController = TextEditingController();
  TextEditingController numeroAgressoresController = TextEditingController();
  TextEditingController localizacaoController = TextEditingController();
  double? latitude;
  double? longitude;
  DateTime? dataInicial;
  String? tipo;
  String? estavaArmado;
  String? tipoArma;
  String? tipoAgressao;
  bool carregandoTela = false;
  List<Armas> tipoArmas = [];
  Exception? error;
  List<Bens> bensSelecionados = [];
  final formKey = GlobalKey<FormState>();

  Future<void> initState() async {
    try {
      carregandoTela = true;
      notifyListeners();
      var armas = await ocorrenciaRepository.findAllArmas();

      tipoArmas = armas.getOrThrow();

      carregandoTela = false;
      notifyListeners();
    } on Exception catch (exception) {
      error = exception;
      carregandoTela = false;
    } finally {
      notifyListeners();
    }
  }

  void clearError() {
    error = null;
  }

  Future<bool> saveOcorrencia() async {
    carregandoTela = true;
    notifyListeners();
    try {
      if (formKey.currentState!.validate()) {
        _validacoesCamposOcorrencia();

        var localizacaoRequest = LocalizacaoOcorrencia(
          cep: "",
          latitude: latitude!,
          longitude: longitude!,
          cidade: "",
          bairro: "",
          rua: "",
          numero: 0,
        );

        var ocorrenciaRequest = Ocorrencia(
          descricao: descricaoController.text,
          dataHora: dataSelecionada!,
          localizacao: localizacaoRequest,
        );

        if (tipo == "R") {
          var assaltoRequest = Assalto(
            qtdAgressores: int.parse(numeroAgressoresController.text),
            possuiArma: estavaArmado == 'S',
            tentativa: false,
            tipoArmaId: tipoArma ?? "",
            tipoBensId: bensSelecionados.map((p) => p.id).toList(),
            ocorrencia: ocorrenciaRequest,
          );

          var retorno = await ocorrenciaRepository.postAssalto(assaltoRequest);

          retorno.getOrThrow();
        } else if (tipo == "F") {
          var rouboRequest = Roubo(
            tentativa: false,
            tipoBensId: bensSelecionados.map((p) => p.id).toList(),
            ocorrencia: ocorrenciaRequest,
          );

          var retorno = await ocorrenciaRepository.postRoubo(rouboRequest);

          retorno.getOrThrow();
        }else if (tipo == "A") {
          var agressaoRequest = Agressao(
            qtdAgressores: int.parse(numeroAgressoresController.text),
            fisica: tipoAgressao == "F" || tipoAgressao == "A",
            verbal: tipoAgressao == "V" || tipoAgressao == "A",
            ocorrencia: ocorrenciaRequest,
          );

          var retorno = await ocorrenciaRepository.postAgressao(agressaoRequest);

          retorno.getOrThrow();
        }

        resetarControllers();

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

  void _validacoesCamposOcorrencia() {
    final brasilia = tz.getLocation('America/Sao_Paulo');
    var dataHoraAtual = tz.TZDateTime.now(brasilia);

    if (dataSelecionada!.isAfter(dataHoraAtual)) {
      throw Exception("Data selecionada é maior que a data atual");
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final brasilia = tz.getLocation('America/Sao_Paulo');
    dataInicial ??= tz.TZDateTime.now(brasilia);

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

    dataSelecionada = DateTime(
      data.year,
      data.month,
      data.day,
      hora.hour,
      hora.minute,
    );

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

  void resetarControllers() {
    dateController.clear();
    descricaoController.clear();
    numeroAgressoresController.clear();
    estavaArmado = null;
    tipoArma = null;
    tipoAgressao = null;
    localizacaoController.clear();
    bensSelecionados.clear();
    latitude = null;
    longitude = null;
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
        latitude = retornoLocalizacaoSelecionada.latitude;
        longitude = retornoLocalizacaoSelecionada.longitude;
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
