import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';
import 'package:notifica_crimes_frontend/ui/choose_location_map/view_model/choose_location_map_view_model.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/button_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/search_text_form_field.dart';

class ChooseLocationMapScreen extends StatefulWidget {
  const ChooseLocationMapScreen({super.key, required this.viewModel});

  final ChooseLocationMapViewModel viewModel;

  @override
  State<ChooseLocationMapScreen> createState() =>
      _ChooseLocationMapScreenState();
}

class _ChooseLocationMapScreenState extends State<ChooseLocationMapScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.addListener(() {
      final error = widget.viewModel.error;
      if (error != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              backgroundColor: Colors.redAccent,
            ),
          );
          widget.viewModel.clearError(); // limpa depois que mostrar
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(ColorsConstants.azulPadraoApp),
        iconTheme: IconThemeData(
          color: Colors.white, // Cor da setinha
        ),
        title: Text(
          "Escolha uma localização",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (BuildContext context, _) {
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(-23.22815468536845, -45.896856363457964),
                  zoom: 14.4746,
                ),
                onMapCreated: (controller) =>
                    widget.viewModel.controllerPlace.complete(controller),
                onTap: (argument) {
                  widget.viewModel.onTapMap(argument);
                },
                markers: <Marker>{
                  if (widget.viewModel.markerLocalSelecionado != null)
                    widget.viewModel.markerLocalSelecionado!,
                },
              ),
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                bottom: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: SearchTextFormField(
                    controllerSearch: widget.viewModel.controllerSearch,
                    digitando: widget.viewModel.digitando,
                    onTapCloseButton: widget.viewModel.onTapCloseButton,
                    onChangedSearch: widget.viewModel.onChangedSearch,
                    onTapSearchText: widget.viewModel.onTapSearchText,
                    placesPrediction: widget.viewModel.placesPrediction,
                    onTapSearchLocation: widget.viewModel.onTapSearchLocation,
                  ),
                ),
              ),
              Positioned(
                bottom: 40,
                left: 0,
                right: 0, 
                child: Center(
                  child: SizedBox(
                    width: 300,
                    child: ButtonDefault(
                      onPressed: widget.viewModel.localSelecionado == null ? null : (){
                        widget.viewModel.onPressedSaveButton(context);
                      },
                      label: "Salvar localização", 
                      icon: Icons.save, 
                      backgroundColor: Color(ColorsConstants.verdeBotaoSalvar)
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
