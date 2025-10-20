import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';

class TextFormFieldDefault extends StatefulWidget {
  const TextFormFieldDefault({super.key, required this.controller, required this.mensagemValidacao});

  final TextEditingController controller;
  final String mensagemValidacao;

  @override
  State<TextFormFieldDefault> createState() => _TextFormFieldDefaultState();
}

class _TextFormFieldDefaultState extends State<TextFormFieldDefault> {
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
              "Quantidade de agressores",
            ),
          ),
        ),
        TextFormField(
          controller: widget.controller,
          validator: (valor) {
            if (valor == null || valor.isEmpty) {
              return widget.mensagemValidacao;
            }
            return null; // null = válido
          },
          keyboardType: TextInputType.number,
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
              borderSide: BorderSide(
                width: 1.5,
                color: Colors.redAccent, // Cor da borda quando há erro
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                width: 1.5,
                color:
                    Colors.redAccent, // Borda vermelha quando focado com erro
              ),
            ),
            errorStyle: TextStyle(
              color: Colors.red[700],
              fontWeight: FontWeight.bold,
            ),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ],
    );
  }
}
