import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';
import 'package:notifica_crimes_frontend/ui/login/view_model/login_view_model.dart';
import 'package:notifica_crimes_frontend/ui/login/widgets/login_screen.dart';

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
      theme: ThemeData(
        fontFamily: "Open_sans",
        useMaterial3: true,
      ),
      home: LoginScreen(viewModel: LoginViewModel(),)
    );
  }
}


