import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:notifica_crimes_frontend/config/colors_constants.dart';
import 'package:notifica_crimes_frontend/data/services/api/model/prediction_place_request/center_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/api/model/prediction_place_request/circle_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/api/model/prediction_place_request/location_bias_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/api/model/prediction_place_request/place_prediction_request_api_model.dart';
import 'package:notifica_crimes_frontend/data/services/api/api_client.dart';
import 'package:notifica_crimes_frontend/ui/core/ui/drawer_default.dart';
import 'package:notifica_crimes_frontend/ui/home/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerDefault(),
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
                top: 40,
                left: 0,
                right: 0,
                bottom: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 270,
                        child: TextField(
                          controller: widget.viewModel.controllerSearch,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                          decoration: InputDecoration(
                            fillColor: Color(ColorsConstants.azulPadraoApp),
                            filled: true,
                            labelText: "Busque um endereço",
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),

                            suffixIcon: widget.viewModel.digitando
                                ? IconButton(
                                    onPressed: () async {
                                      widget.viewModel.onTapCloseButton();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  )
                                : Icon(Icons.search, color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onChanged: (text) async {
                            await widget.viewModel.onChangedSearch(text);
                          },
                          onTap: () async {
                            await widget.viewModel.onTapSearchText();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 270,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: widget.viewModel.placesPrediction.length,
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
                                  var localSelecionado =
                                      widget.viewModel.placesPrediction[index];

                                  var idLocalSelecionado =
                                      localSelecionado.placeId;

                                  await widget.viewModel.onTapSearchLocation(
                                    idLocalSelecionado,
                                  );
                                },
                                title: Text(
                                  widget.viewModel.placesPrediction[index].text,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
