import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shelter/data/models/models.dart';
import 'package:shelter/domain/cubits/cubits.dart';
import 'package:shelter/presentation/widgets/widgets.dart';

import 'local_widgets/shelter_marker.dart';
import 'map_tile_layer.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MapCubit>(context).loadShelters();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<MapCubit, MapState>(
        builder: (context, state) {
          if (state is MapLoaded) {
            return _buildUI(
              center: state.initialCenter,
              shelters: state.shelters,
            );
          }
          return const ShLoadingScreen();
        },
      );

  Widget _buildUI({
    required LatLng center,
    required List<ShelterModel> shelters,
  }) =>
      Scaffold(
        body: FlutterMap(
          options: MapOptions(
            center: center,
            zoom: 13,
            maxZoom: 20,
          ),
          layers: [
            MapTileLayer.layer(context),
            MarkerLayerOptions(
              markers: shelters
                  .map((sh) => ShelterMarker(sh.properties.point!))
                  .toList(),
            ),
          ],
        ),
      );
}
