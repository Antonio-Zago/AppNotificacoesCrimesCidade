import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';
import 'package:notifica_crimes_frontend/data/repositories/map/map_repository.dart';
import 'package:notifica_crimes_frontend/data/repositories/map/map_repository_remote.dart';
import 'package:notifica_crimes_frontend/data/services/api/api_client.dart';
import 'package:notifica_crimes_frontend/ui/home/view_model/home_view_model.dart';
import 'package:notifica_crimes_frontend/ui/home/widgets/home_screen.dart';
import 'package:notifica_crimes_frontend/ui/login/view_model/login_view_model.dart';
import 'package:notifica_crimes_frontend/ui/login/widgets/login_screen.dart';
import 'package:notifica_crimes_frontend/ui/register/view_model/register_view_model.dart';
import 'package:notifica_crimes_frontend/ui/register/widgets/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => Dio()),
        ProxyProvider<Dio, ApiClient>(
          //Aqui utilizei o log provider para conseguir acessar ao dio que já foi instanciado anteriormente
          update: (BuildContext context, dio, previous) => ApiClient(dio: dio),
        ),
        Provider(
          create: (context) =>
              MapRepositoryRemote(apiClient: context.read())
                  as MapRepository,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Open_sans", useMaterial3: true),
      routes: {
        '/': (context) => LoginScreen(viewModel: LoginViewModel()),
        '/register': (context) =>
            RegisterScreen(viewModel: RegisterViewModel()),
        '/home': (context) => HomeScreen(viewModel: HomeViewModel(mapRepository: context.read<MapRepository>(), uuid: Uuid())),
      },
    );
  }
}
