import 'package:flutter/material.dart';

class ButtonSmallDefault extends StatefulWidget {
  const ButtonSmallDefault({super.key, required this.label, required this.onPressed, required this.icon});

  final String label;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  State<ButtonSmallDefault> createState() => _ButtonSmallDefaultState();
}

class _ButtonSmallDefaultState extends State<ButtonSmallDefault> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 35,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
            side: BorderSide(width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              size: 18,
              widget.icon,
              color: Colors.black,
            ), // ícone como sufixo

            Padding(
              padding: EdgeInsetsGeometry.only(left: 10),
              child: Text(
                widget.label,
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
