import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notifica_crimes_frontend/config/api_routes.dart';
import 'package:notifica_crimes_frontend/config/interceptors/auth_redirect.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.storage, required this.dio});

  final FlutterSecureStorage storage;
  final Dio dio;

  bool _isRefreshing = false;
  List<Function(String)> _queuedRequests = [];

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final skipAuth = options.extra['skipAuth'] == true;

    if (!skipAuth) {
      var token = await storage.read(key: 'token');

      if (token != null) {
        options.headers.addAll({'Authorization': 'Bearer $token'});
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Se não for 401, não tenta refresh
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    final refreshToken = await storage.read(key: 'refresh_token');
    if (refreshToken == null) {
      return handler.next(err); // Não tem refresh, falha
    }

    final accessToken = await storage.read(key: 'token');
    if (accessToken == null) {
      return handler.next(err); // Não tem access token, falha
    }

    // Se já está renovando o token, colocar requisição na fila
    if (_isRefreshing) {
      _queuedRequests.add((newToken) {
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
      });
      return;
    }

    _isRefreshing = true;

    try {
      // ⬇️ Chamada ao endpoint de refresh
      final response = await dio.post(
        '${ApiRoutes.urlBase}/auth/refresh-token',
        data: {'RefreshToken': refreshToken, 'AccessToken': accessToken},
      );

      final newToken = response.data['token'];
      final newRefresh = response.data['refreshToken'];

      // salvar novos tokens
      await storage.write(key: 'token', value: newToken);
      await storage.write(key: 'refresh_token', value: newRefresh);

      // Executar todas as requisições que ficaram esperando
      for (var callback in _queuedRequests) {
        callback(newToken);
      }
      _queuedRequests.clear();

      // Recriar a requisição original
      final newRequest = await _retry(err.requestOptions, newToken);

      handler.resolve(newRequest);
    } catch (e) {
      // refresh falhou → usuário precisa logar novamente
      await storage.delete(key: 'token');
      await storage.delete(key: 'refresh_token');
      // Notifica a aplicação para abrir login
      if (AuthRedirect.goToLogin != null) {
        AuthRedirect.goToLogin!();
      }
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  // Função para reenviar a requisição
  Future<Response<dynamic>> _retry(
    RequestOptions requestOptions,
    String newToken,
  ) async {
    final options = Options(
      method: requestOptions.method,
      headers: {...requestOptions.headers, 'Authorization': 'Bearer $newToken'},
    );

    return dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
