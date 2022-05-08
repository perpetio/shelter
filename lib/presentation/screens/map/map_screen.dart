import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:shelter/data/models/models.dart';
import 'package:shelter/domain/cubits/cubits.dart';
import 'package:shelter/presentation/widgets/widgets.dart';

import 'local_widgets/map_tile_layer.dart';
import 'local_widgets/sh_location_marker.dart';
import 'local_widgets/shelters_marker_cluster_layer.dart';

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
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await Geolocator.requestPermission(); //TODO extract request, add logic
    });
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
            plugins: [MarkerClusterPlugin(), const LocationMarkerPlugin()],
          ),
          layers: [
            MapTileLayer.layer(context),
            ShLocationMarker.marker(),
            SheltersMarkerClusterLayer.layer(shelters: shelters),
          ],
        ),
      );
}
