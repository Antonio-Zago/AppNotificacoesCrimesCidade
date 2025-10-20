import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';

class DropdownButtonDefault extends StatefulWidget {
  const DropdownButtonDefault({
    super.key,
    required this.onChanged,
    required this.valorSelecionado,
    required this.opcoes,
    required this.titulo,
  });

  final String? valorSelecionado;
  final ValueChanged<String?> onChanged;
  final List<DropdownMenuItem<String>> opcoes;
  final String titulo;

  @override
  State<DropdownButtonDefault> createState() => _DropdownButtonDefaultState();
}

class _DropdownButtonDefaultState extends State<DropdownButtonDefault> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, top: 20),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              widget.titulo,
            ),
          ),
        ),
        DropdownButtonFormField<String>(
          initialValue: widget.valorSelecionado,
          items: widget.opcoes,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                width: 1.5,
                color: Color(ColorsConstants.azulPadraoApp),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                width: 1.5,
                color: Color(ColorsConstants.azulPadraoApp),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 1.5, color: Colors.redAccent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 1.5, color: Colors.redAccent),
            ),
            errorStyle: TextStyle(
              color: Colors.red[700],
              fontWeight: FontWeight.bold,
            ),
            fillColor: Colors.white,
            filled: true,
          ),
          onChanged: widget.onChanged,
          validator: (valor) {
            if (valor == null || valor.isEmpty) {
              return 'Selecione uma opção';
            }
            return null;
          },
        ),
      ],
    );
  }
}
