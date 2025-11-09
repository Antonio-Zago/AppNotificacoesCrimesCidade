class LocalizacaoOcorrencia {
  final String? cep;
  final double latitude;
  final double longitude;
  final String? cidade;
  final String? bairro;
  final String? rua;
  final int? numero;

  LocalizacaoOcorrencia({required this.cep, required this.latitude, required this.longitude, required this.cidade, required this.bairro, required this.rua, required this.numero});
}