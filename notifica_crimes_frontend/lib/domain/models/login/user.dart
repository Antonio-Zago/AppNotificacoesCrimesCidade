class User {
  final String token;
  final String refreshToken;
  final DateTime expiration;
  final String nome;
  final String email;
  final String? foto;
  final bool emailValidado;
  final int? codigoValidacaoEmail;
  final DateTime? expiracaoCodigoValidacaoEmail;

  User({required this.token, required this.refreshToken, required this.expiration, required this.nome, required this.email,required this.foto,required this.emailValidado,required this.codigoValidacaoEmail,required this.expiracaoCodigoValidacaoEmail, });
}