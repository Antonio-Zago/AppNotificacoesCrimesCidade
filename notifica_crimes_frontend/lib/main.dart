import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';
import 'package:notifica_crimes_frontend/config/dependencies.dart';
import 'package:notifica_crimes_frontend/config/interceptors/auth_redirect.dart';
import 'package:notifica_crimes_frontend/data/repositories/login/login_repository.dart';
import 'package:notifica_crimes_frontend/data/repositories/map/map_repository.dart';
import 'package:notifica_crimes_frontend/data/repositories/map/map_repository_remote.dart';
import 'package:notifica_crimes_frontend/data/repositories/ocorrencias/ocorrencia_repository.dart';
import 'package:notifica_crimes_frontend/data/repositories/ocorrencias/ocorrencia_repository_remote.dart';
import 'package:notifica_crimes_frontend/data/services/api/api_client.dart';
import 'package:notifica_crimes_frontend/ui/choose_bens/view_model/choose_bens_view_model.dart';
import 'package:notifica_crimes_frontend/ui/choose_bens/widgets/choose_bens_screen.dart';
import 'package:notifica_crimes_frontend/ui/choose_location_map/view_model/choose_location_map_view_model.dart';
import 'package:notifica_crimes_frontend/ui/choose_location_map/widgets/choose_location_map_screen.dart';
import 'package:notifica_crimes_frontend/ui/home/view_model/home_view_model.dart';
import 'package:notifica_crimes_frontend/ui/home/widgets/home_screen.dart';
import 'package:notifica_crimes_frontend/ui/login/view_model/login_view_model.dart';
import 'package:notifica_crimes_frontend/ui/login/widgets/login_screen.dart';
import 'package:notifica_crimes_frontend/ui/ocorrencia/view_model/ocorrencia_view_model.dart';
import 'package:notifica_crimes_frontend/ui/ocorrencia/widgets/ocorrencia_screen.dart';
import 'package:notifica_crimes_frontend/ui/register/view_model/register_view_model.dart';
import 'package:notifica_crimes_frontend/ui/register/widgets/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:uuid/uuid.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  runApp(
    MultiProvider(
      providers: providersRemote,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {

    // Registro do callback global
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AuthRedirect.goToLogin = () {
        Navigator.of(globalNavigatorKey.currentContext!)
            .pushNamedAndRemoveUntil('/login', (_) => false);
      };
    });

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Open_sans", useMaterial3: true),
      navigatorKey: globalNavigatorKey,
      routes: {
        '/login': (context) => LoginScreen(viewModel: LoginViewModel(loginRepository: context.read<LoginRepository>())),
        '/register': (context) =>
            RegisterScreen(viewModel: RegisterViewModel()),
        '/': (context) => HomeScreen(viewModel: HomeViewModel(mapRepository: context.read<MapRepository>(), uuid: Uuid(), ocorrenciaRepository: context.read<OcorrenciaRepository>(), storage: context.read())),
        '/ocorrencia': (context) => OcorrenciaScreen(viewModel: OcorrenciaViewModel(ocorrenciaRepository: context.read<OcorrenciaRepository>())),
        '/choose-location-map': (context) => ChooseLocationMapScreen(viewModel: ChooseLocationMapViewModel(mapRepository: context.read<MapRepository>(), uuid: Uuid())),
        '/choose-bens': (context) => ChooseBensScreen(viewModel: ChooseBensViewModel(ocorrenciaRepository: context.read<OcorrenciaRepository>()))
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
