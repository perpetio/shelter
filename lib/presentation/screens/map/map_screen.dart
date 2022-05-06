import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'map_tile_layer.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _lvivCityCenter = LatLng(49.841863, 24.031566); //TODO extract

  @override
  Widget build(BuildContext context) => Scaffold(
        body: FlutterMap(
          options: MapOptions(
            center: _lvivCityCenter,
            zoom: 13,
            maxZoom: 20,
          ),
          layers: [
            MapTileLayer.layer(context),
          ],
        ),
      );
}
