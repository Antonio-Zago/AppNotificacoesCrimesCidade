import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/circular_progress_indicator_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/drawer_default.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/search_text_form_field.dart';
import 'package:notifica_crimes_frontend/ui/home/view_model/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    Future.microtask(() {
      widget.viewModel.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerDefault(),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (BuildContext context, _) {
          return widget.viewModel.carregandoTela
              ? Center(
                  child: SizedBox(
                    width: 80, // tamanho personalizado
                    height: 80,
                    child: CircularProgressIndicatorDefault(),
                  ),
                )
              : Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(-23.22815468536845, -45.896856363457964),
                        zoom: 14.4746,
                      ),
                      onMapCreated: (controller) {
                        if (!widget.viewModel.controllerPlace.isCompleted) {
                          widget.viewModel.controllerPlace.complete(controller);
                        }
                      },

                      markers: widget.viewModel.retornarMarcadoresOcorrencias(
                        context,
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          color: Color(ColorsConstants.azulPadraoApp),
                        ),

                        child: IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          icon: Icon(Icons.menu, color: Colors.white, size: 35),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 150,
                      left: 10,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(ColorsConstants.azulPadraoApp),
                            width: 1.5,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: widget.viewModel.valorSelecionado,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Color(ColorsConstants.azulPadraoApp),
                            ),
                            style: TextStyle(
                              color: Color(ColorsConstants.azulPadraoApp),
                              fontSize: 14,
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: "ano",
                                child: Text("Ano anterior"),
                              ),
                              DropdownMenuItem(
                                value: "mes",
                                child: Text("Mês anterior"),
                              ),
                              DropdownMenuItem(
                                value: "semana",
                                child: Text("Semana anterior"),
                              ),
                            ],
                            onChanged: (value) async {
                              await widget.viewModel
                                  .alterarFiltroDataSelecionada(value!);
                            },
                          ),
                        ),
                      ),
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
                          onTapSearchLocation:
                              widget.viewModel.onTapSearchLocation,
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
