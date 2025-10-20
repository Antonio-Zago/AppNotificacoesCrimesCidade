import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';
import 'package:notifica_crimes_frontend/domain/models/place_prediction/place_prediction.dart';

class SearchTextFormField extends StatefulWidget {
  const SearchTextFormField({
    super.key,
    required this.controllerSearch,
    required this.digitando,
    required this.onTapCloseButton,
    required this.onChangedSearch,
    required this.onTapSearchText,
    required this.placesPrediction,
    required this.onTapSearchLocation,
  });

  final TextEditingController controllerSearch;
  final bool digitando;
  final void Function() onTapCloseButton;
  final Future<void> Function(String) onChangedSearch;
  final Future<void> Function() onTapSearchText;
  final List<PlacePrediction> placesPrediction;
  final Future<void> Function(String) onTapSearchLocation;

  @override
  State<SearchTextFormField> createState() => _SearchTextFormFieldState();
}

class _SearchTextFormFieldState extends State<SearchTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 270,
          child: TextField(
            controller: widget.controllerSearch,
            style: TextStyle(color: Colors.white, fontSize: 12),
            decoration: InputDecoration(
              fillColor: Color(ColorsConstants.azulPadraoApp),
              filled: true,
              labelText: "Busque um endereço",
              labelStyle: TextStyle(color: Colors.white, fontSize: 12),

              suffixIcon: widget.digitando
                  ? IconButton(
                      onPressed: widget.onTapCloseButton,
                      icon: Icon(Icons.close, color: Colors.white),
                    )
                  : Icon(Icons.search, color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onChanged: widget.onChangedSearch,
            onTap: widget.onTapSearchText,
          ),
        ),
        SizedBox(
          width: 270,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.placesPrediction.length,
            padding: EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Color(
                    ColorsConstants.azulPadraoApp,
                  ), // cor de fundo do tile
                  borderRadius: BorderRadius.circular(
                    12,
                  ), // cantos arredondados
                ),
                child: ListTile(
                  dense: true,
                  onTap: () async {
                    var localSelecionado = widget.placesPrediction[index];

                    var idLocalSelecionado = localSelecionado.placeId;
                    await widget.onTapSearchLocation(idLocalSelecionado);
                  },
                  title: Text(
                    widget.placesPrediction[index].text,
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
