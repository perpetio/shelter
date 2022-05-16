import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:shelter/domain/cubits/cubits.dart';
import 'package:shelter/presentation/styles/styles.dart';
import 'package:shelter/presentation/widgets/widgets.dart';

import 'local_widgets/map_tile_layer.dart';
import 'local_widgets/sh_location_marker.dart';
import 'local_widgets/shelter_card.dart';
import 'local_widgets/shelters_marker_cluster_layer.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  MapCubit get _cubit => BlocProvider.of<MapCubit>(context);

  @override
  void initState() {
    super.initState();
    _cubit.stream.listen((state) {
      if (state is MapLoaded && state.moveToPoint != null) {
        _mapController.move(state.moveToPoint!, 15);
      }
    });
    _cubit.loadMap();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<MapCubit, MapState>(
        builder: (context, state) {
          if (state is MapLoaded) {
            return _buildUI(state);
          }
          return const ShLoadingScreen();
        },
      );

  Widget _buildUI(MapLoaded state) => Stack(
        children: [
          _map(state),
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 16.w, bottom: 16.w),
                  child: _locationButton(showLocation: state.showLocation),
                ),
                if (state.selectedShelter != null)
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: ShelterCard(
                      properties: state.selectedShelter!.properties,
                      onButtonPressed: _cubit.toggleRouteInProgress,
                      routeInProgress: state.routeInProgress,
                    ),
                  ),
              ],
            ),
          ),
        ],
      );

  Widget _map(MapLoaded state) => FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: state.initialCenter,
          zoom: 14,
          maxZoom: 20,
          plugins: [
            MarkerClusterPlugin(),
            if (state.showLocation) const LocationMarkerPlugin(),
          ],
          onTap: (_, __) => _cubit.resetSelectedShelter(),
        ),
        layers: [
          MapTileLayer.layer(context),
          if (state.showLocation) ShLocationMarker.marker(),
          SheltersMarkerClusterLayer.layer(
            shelters: state.shelters,
            onMarkerTap: (shelter) async {
              await _cubit.selectShelter(shelter);
              //TODO find better solution
              await Future.delayed(const Duration(milliseconds: 100));
              _cubit.buildRoute();
            },
            selectedShelter: state.selectedShelter,
          ),
          if (state.routePoints != null) _polylineLayer(state.routePoints!),
        ],
      );

  Widget _locationButton({required bool showLocation}) => SizedBox.square(
        dimension: 48.w,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(
              showLocation ? Icons.my_location : Icons.location_searching,
              size: 16.w,
            ),
            onPressed: _cubit.toggleLocation,
          ),
        ),
      );

  LayerOptions _polylineLayer(List<LatLng> points) => PolylineLayerOptions(
        polylines: [
          Polyline(
            points: points,
            color: ShColors.sushi,
            strokeWidth: 5.w,
            isDotted: true,
          ),
        ],
      );
}
