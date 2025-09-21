import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';

class CircularProgressIndicatorDefault extends StatefulWidget {
  const CircularProgressIndicatorDefault({super.key});

  @override
  State<CircularProgressIndicatorDefault> createState() =>
      _CircularProgressIndicatorDefaultState();
}

class _CircularProgressIndicatorDefaultState
    extends State<CircularProgressIndicatorDefault> {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: Color(ColorsConstants.azulPadraoApp),
      color: Colors.white,
    );
  }
}
