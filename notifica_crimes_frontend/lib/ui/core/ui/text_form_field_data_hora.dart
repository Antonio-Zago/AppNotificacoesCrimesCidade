import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';

class TextFormFieldDataHora extends StatefulWidget {
  const TextFormFieldDataHora({
    super.key,
    required this.controller,
    required this.onTap,
    required this.mensagemValidacao,
  });

  final TextEditingController controller;
  final void Function() onTap;
  final String mensagemValidacao;

  @override
  State<TextFormFieldDataHora> createState() => _TextFormFieldDataHoraState();
}

class _TextFormFieldDataHoraState extends State<TextFormFieldDataHora> {
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
              "Data e hora",
            ),
          ),
        ),
        TextFormField(
          controller: widget.controller,
          validator: (valor) {
            if (valor == null || valor.isEmpty) {
              return widget.mensagemValidacao;
            }
            return null;
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                width: 1.5,
                color: Color(ColorsConstants.azulPadraoApp),
              ),
            ),
            hintText: "dd/mm/aaaa hh:mm",
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
            suffixIcon: Icon(Icons.calendar_month),
          ),
          onTap: widget.onTap,
        ),
      ],
    );
  }
}
