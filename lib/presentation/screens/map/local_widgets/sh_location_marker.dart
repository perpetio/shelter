import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shelter/presentation/styles/styles.dart';

class ShLocationMarker {
  static LayerOptions marker() => LocationMarkerLayerOptions(
        marker: const DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ShColors.sushi,
          ),
        ),
        markerSize: Size(16.w, 16.w),
        accuracyCircleColor: ShColors.sushi.withOpacity(0.2),
        headingSectorRadius: 40.r,
        headingSectorColor: ShColors.sushi,
      );
}
