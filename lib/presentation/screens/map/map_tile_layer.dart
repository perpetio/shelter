import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MapTileLayer {
  static TileLayerOptions layer(BuildContext context) => TileLayerOptions(
        urlTemplate:
            'https://{s}.basemaps.cartocdn.com/{variant}/{z}/{x}/{y}{r}.png',
        subdomains: ['a', 'b', 'c', 'd'],
        additionalOptions: {
          'variant': Theme.of(context).brightness == Brightness.light
              ? 'light_all'
              : 'dark_all',
        },
        maxNativeZoom: 20,
        maxZoom: 20,
      );
}
