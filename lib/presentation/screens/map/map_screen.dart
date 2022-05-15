import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:shelter/data/repositories/routes/ors_routes_repository.dart';
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
  final MapController _mapController = MapController();
  MapCubit get _cubit => BlocProvider.of<MapCubit>(context);
  Polyline? _polyline;

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
          Positioned(
            right: 16.w,
            bottom: 30.h,
            child: _locationButton(showLocation: state.showLocation),
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
        ),
        layers: [
          MapTileLayer.layer(context),
          if (state.showLocation) ShLocationMarker.marker(),
          SheltersMarkerClusterLayer.layer(
            shelters: state.shelters,
            onMarkerTap: _cubit.selectShelter,
            selectedShelter: state.selectedShelter,
          ),
          PolylineLayerOptions(
            polylines: [
              if (_polyline != null) _polyline!,
            ],
          )
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
            // onPressed: () async {
            //   final points = await ORSRoutesRepository().getRoutePoints(
            //     start: LatLng(49.824610, 23.890120),
            //     end: LatLng(49.824538, 23.932142),
            //   );
            //   setState(() {
            //     _polyline = Polyline(
            //       points: points,
            //       strokeWidth: 2.w,
            //       isDotted: true,
            //     );
            //   });
            // },
          ),
        ),
      );
}
