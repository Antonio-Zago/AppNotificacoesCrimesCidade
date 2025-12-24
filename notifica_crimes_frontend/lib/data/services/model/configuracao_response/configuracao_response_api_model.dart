
import 'package:json_annotation/json_annotation.dart';

part 'configuracao_response_api_model.g.dart';

@JsonSerializable()
class ConfiguracaoResponseApiModel {

  ConfiguracaoResponseApiModel( {required this.notificaLocalizacao,required this.notificaLocal,required this.distanciaLocalizacao,required this.distanciaLocal,} );

  final bool notificaLocalizacao;
  final bool notificaLocal;
  final double distanciaLocalizacao;
  final double distanciaLocal;
  
  Map<String, dynamic> toJson() => _$ConfiguracaoResponseApiModelToJson(this);

  factory ConfiguracaoResponseApiModel.fromJson(Map<String, dynamic> json) => _$ConfiguracaoResponseApiModelFromJson(json);
}