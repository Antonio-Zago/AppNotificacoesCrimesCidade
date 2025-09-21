import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';

class TextFormFieldLoginCadastro extends StatefulWidget {
  const TextFormFieldLoginCadastro({super.key, required this.label, required this.prefixIcon, required this.controller, this.password, this.enabled});

  final String label;
  final Icon prefixIcon;
  final TextEditingController controller;
  final bool? password;
  final bool? enabled;

  @override
  State<TextFormFieldLoginCadastro> createState() =>
      _TextFormFieldLoginCadastroState();
}

class _TextFormFieldLoginCadastroState
    extends State<TextFormFieldLoginCadastro> {

  bool obscuro = false;
  bool ehSenha = false;

  @override
  void initState() {
    
    if(widget.password != null){
      obscuro = widget.password!;
      ehSenha = widget.password!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.text,
      obscureText: obscuro,
      enabled: widget.enabled,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: ehSenha ? IconButton(
          onPressed: (){
            setState(() {
              obscuro = !obscuro;
            });
          }, 
          icon: obscuro ? Icon(Icons.visibility) : Icon(Icons.visibility_off)
        ) : null,
        labelText: widget.label,
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
      ),
    );
  }
}
