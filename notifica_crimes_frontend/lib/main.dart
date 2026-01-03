import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';
import 'package:notifica_crimes_frontend/config/dependencies.dart';
import 'package:notifica_crimes_frontend/config/interceptors/auth_redirect.dart';
import 'package:notifica_crimes_frontend/data/repositories/configuracoes/configuracoes_repository.dart';
import 'package:notifica_crimes_frontend/data/repositories/locais/local_repository.dart';
import 'package:notifica_crimes_frontend/data/repositories/login/login_repository.dart';
import 'package:notifica_crimes_frontend/data/repositories/map/map_repository.dart';
import 'package:notifica_crimes_frontend/data/repositories/map/map_repository_remote.dart';
import 'package:notifica_crimes_frontend/data/repositories/notifications/notification_repository.dart';
import 'package:notifica_crimes_frontend/data/repositories/notifications/notification_repository_remote.dart';
import 'package:notifica_crimes_frontend/data/repositories/ocorrencias/ocorrencia_repository.dart';
import 'package:notifica_crimes_frontend/data/repositories/ocorrencias/ocorrencia_repository_remote.dart';
import 'package:notifica_crimes_frontend/data/services/api/api_client.dart';
import 'package:notifica_crimes_frontend/ui/choose_bens/view_model/choose_bens_view_model.dart';
import 'package:notifica_crimes_frontend/ui/choose_bens/widgets/choose_bens_screen.dart';
import 'package:notifica_crimes_frontend/ui/choose_location_map/view_model/choose_location_map_view_model.dart';
import 'package:notifica_crimes_frontend/ui/choose_location_map/widgets/choose_location_map_screen.dart';
import 'package:notifica_crimes_frontend/ui/configuracoes/view_model/configuracoes_view_model.dart';
import 'package:notifica_crimes_frontend/ui/configuracoes/widgets/configuracoes_screen.dart';
import 'package:notifica_crimes_frontend/ui/edit_local/view_model/edit_local_view_model.dart';
import 'package:notifica_crimes_frontend/ui/edit_local/widgets/edit_local_screen.dart';
import 'package:notifica_crimes_frontend/ui/edit_usuario/view_model/edit_usuario_view_model.dart';
import 'package:notifica_crimes_frontend/ui/edit_usuario/widgets/edit_usuario_screen.dart';
import 'package:notifica_crimes_frontend/ui/home/view_model/home_view_model.dart';
import 'package:notifica_crimes_frontend/ui/home/widgets/home_screen.dart';
import 'package:notifica_crimes_frontend/ui/locais/view_model/locais_view_model.dart';
import 'package:notifica_crimes_frontend/ui/locais/widgets/locais_screen.dart';
import 'package:notifica_crimes_frontend/ui/login/view_model/login_view_model.dart';
import 'package:notifica_crimes_frontend/ui/login/widgets/login_screen.dart';
import 'package:notifica_crimes_frontend/ui/ocorrencia/view_model/ocorrencia_view_model.dart';
import 'package:notifica_crimes_frontend/ui/ocorrencia/widgets/ocorrencia_screen.dart';
import 'package:notifica_crimes_frontend/ui/register/view_model/register_view_model.dart';
import 'package:notifica_crimes_frontend/ui/register/widgets/register_screen.dart';
import 'package:notifica_crimes_frontend/ui/register_local/view_model/register_local_view_model.dart';
import 'package:notifica_crimes_frontend/ui/register_local/widgets/register_local_screen.dart';
import 'package:notifica_crimes_frontend/ui/splash/view_model/splash_view_model.dart';
import 'package:notifica_crimes_frontend/ui/splash/widgets/splash_screen.dart';
import 'package:notifica_crimes_frontend/ui/validacao_email/view_model/validacao_email_view_model.dart';
import 'package:notifica_crimes_frontend/ui/validacao_email/widgets/validacao_email_screen.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:uuid/uuid.dart';



const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'Notificações Importantes',
  description: 'Canal para notificações em foreground',
  importance: Importance.high,
);

void main() async{
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
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
        '/': (context) => SplashScreen(viewModel: SplashViewModel(notificationRepository: context.read<NotificationRepository>())),
        '/login': (context) => LoginScreen(viewModel: LoginViewModel(loginRepository: context.read<LoginRepository>())),
        '/register': (context) =>
            RegisterScreen(viewModel: RegisterViewModel(loginRepository: context.read<LoginRepository>())),
        '/home': (context) => HomeScreen(viewModel: HomeViewModel(mapRepository: context.read<MapRepository>(), uuid: Uuid(), ocorrenciaRepository: context.read<OcorrenciaRepository>(), storage: context.read(), notificationRepository: context.read<NotificationRepository>())),
        '/ocorrencia': (context) => OcorrenciaScreen(viewModel: OcorrenciaViewModel(ocorrenciaRepository: context.read<OcorrenciaRepository>())),
        '/choose-location-map': (context) => ChooseLocationMapScreen(viewModel: ChooseLocationMapViewModel(mapRepository: context.read<MapRepository>(), uuid: Uuid())),
        '/choose-bens': (context) => ChooseBensScreen(viewModel: ChooseBensViewModel(ocorrenciaRepository: context.read<OcorrenciaRepository>())),
        '/locais': (context) => LocaisScreen(viewModel: LocaisViewModel(localRepository: context.read<LocalRepository>())),
        '/new-local': (context) => RegisterLocalScreen(viewModel: RegisterLocalViewModel(localRepository:  context.read<LocalRepository>())),
        '/edit-local': (context) => EditLocalScreen(viewModel: EditLocalViewModel(localRepository:  context.read<LocalRepository>())),
        '/configuracoes': (context) => ConfiguracoesScreen(viewModel: ConfiguracoesViewModel(configuracoesRepository: context.read<ConfiguracoesRepository>())),
        '/edit-perfil': (context) => EditUsuarioScreen(viewModel: EditUsuarioViewModel(configuracoesRepository: context.read<ConfiguracoesRepository>(), storage: context.read())),
        '/validacao-email': (context) => ValidacaoEmailScreen(viewModel: ValidacaoEmailViewModel(loginRepository: context.read<LoginRepository>()))
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
