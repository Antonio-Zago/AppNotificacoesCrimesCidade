import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';
import 'package:notifica_crimes_frontend/ui/login/view_model/login_view_model.dart';
import 'package:notifica_crimes_frontend/ui/login/widgets/login_screen.dart';
import 'package:notifica_crimes_frontend/ui/register/view_model/register_view_model.dart';
import 'package:notifica_crimes_frontend/ui/register/widgets/register_screen.dart';

void main() {
  runApp(const MyApp());
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
        '/register' : (context) => RegisterScreen(viewModel: RegisterViewModel()),
      },
    );
  }
}
