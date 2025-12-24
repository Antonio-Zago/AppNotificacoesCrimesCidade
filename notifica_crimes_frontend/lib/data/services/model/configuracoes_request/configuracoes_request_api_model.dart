
import 'package:json_annotation/json_annotation.dart';

part 'configuracoes_request_api_model.g.dart';

@JsonSerializable()
class ConfiguracoesRequestApiModel {

  ConfiguracoesRequestApiModel( {required this.email,required this.notificaLocalizacao,required this.notificaLocal,required this.distanciaLocalizacao,required this.distanciaLocal,} );

  final String email;
  final bool notificaLocalizacao;
  final bool notificaLocal;
  final double distanciaLocalizacao;
  final double distanciaLocal;
  
  Map<String, dynamic> toJson() => _$ConfiguracoesRequestApiModelToJson(this);

  factory ConfiguracoesRequestApiModel.fromJson(Map<String, dynamic> json) => _$ConfiguracoesRequestApiModelFromJson(json);
}