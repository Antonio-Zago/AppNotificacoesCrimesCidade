class User {
  final String token;
  final String refreshToken;
  final DateTime expiration;
  final String nome;
  final String email;
  final String? foto;

  User({required this.token, required this.refreshToken, required this.expiration, required this.nome, required this.email,required this.foto, });
}