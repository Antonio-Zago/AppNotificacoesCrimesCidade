import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';

class ButtonLoginCadastro extends StatefulWidget {
  const ButtonLoginCadastro({
    super.key,
    required this.onPressed,
    required this.label, 
    required this.icon,
  });

  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  @override
  State<ButtonLoginCadastro> createState() => _ButtonLoginCadastroState();
}

class _ButtonLoginCadastroState extends State<ButtonLoginCadastro> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(ColorsConstants.azulPadraoApp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 25),
            Text(
              widget.label,
              style: TextStyle(
                color: Colors.white, 
                fontSize: 15
              ),
            ),
            Icon(
              size: 25,
              widget.icon,
              color: Colors.white,
            ), // ícone como sufixo
          ],
        ),
      ),
    );
  }
}
