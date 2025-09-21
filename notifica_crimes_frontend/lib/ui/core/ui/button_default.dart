import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';

class ButtonDefault extends StatefulWidget {
  const ButtonDefault({
    super.key,
    required this.onPressed,
    required this.label, 
    required this.icon,
  });

  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  @override
  State<ButtonDefault> createState() => _ButtonDefaultState();
}

class _ButtonDefaultState extends State<ButtonDefault> {
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
