import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notifica_crimes_frontend/config/api_routes.dart';
import 'package:notifica_crimes_frontend/config/interceptors/auth_interceptor.dart';
import 'package:notifica_crimes_frontend/data/repositories/login/login_repository.dart';
import 'package:notifica_crimes_frontend/data/repositories/login/login_repository_remote.dart';
import 'package:notifica_crimes_frontend/data/repositories/map/map_repository.dart';
import 'package:notifica_crimes_frontend/data/repositories/map/map_repository_remote.dart';
import 'package:notifica_crimes_frontend/data/repositories/ocorrencias/ocorrencia_repository.dart';
import 'package:notifica_crimes_frontend/data/repositories/ocorrencias/ocorrencia_repository_local.dart';
import 'package:notifica_crimes_frontend/data/repositories/ocorrencias/ocorrencia_repository_remote.dart';
import 'package:notifica_crimes_frontend/data/services/api/api_client.dart';
import 'package:notifica_crimes_frontend/data/services/local/local_data_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// Configure dependencies for remote data.
/// This dependency list uses repositories that connect to a remote server.
List<SingleChildWidget> get providersRemote {
  return [
    Provider(create: (context) => FlutterSecureStorage()),
    Provider(create: (context) {
      final dio = Dio();

      dio.interceptors.add(AuthInterceptor(storage: context.read(), dio: dio));

      return dio;
    } ),    
    Provider(create: (context) => ApiClient(dio: context.read())),
    Provider(
      create: (context) =>
          MapRepositoryRemote(apiClient: context.read()) as MapRepository,
    ),
    Provider(
      create: (context) =>
          OcorrenciaRepositoryRemote(apiClient: context.read())
              as OcorrenciaRepository,
    ),
    Provider(
      create: (context) =>
          LoginRepositoryRemote(apiClient: context.read(), storage: context.read())
              as LoginRepository,
    ),
  ];
}

/// Configure dependencies for local data.
/// This dependency list uses repositories that provide local data.
/// The user is always logged in.
List<SingleChildWidget> get providersLocal {
  return [
    Provider(create: (context) => Dio()),
    Provider(create: (context) => ApiClient(dio: context.read())),
    Provider(create: (context) => LocalDataService()),
    Provider(
      create: (context) =>
          MapRepositoryRemote(apiClient: context.read()) as MapRepository,
    ),
    Provider(
      create: (context) =>
          OcorrenciaRepositoryLocal(localDataService: context.read())
              as OcorrenciaRepository,
    ),
  ];
}
