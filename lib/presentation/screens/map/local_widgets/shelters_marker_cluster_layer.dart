import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shelter/data/models/models.dart';
import 'package:shelter/presentation/styles/styles.dart';

import 'shelter_marker.dart';

class SheltersMarkerClusterLayer {
  static MarkerClusterLayerOptions layer({
    required List<ShelterModel> shelters,
    required void Function(ShelterModel) onMarkerTap,
     ShelterModel? selectedShelter,
  }) =>
      MarkerClusterLayerOptions(
        markers: shelters
            .map(
              (sh) => ShelterMarker.marker(
                sh,
                onMarkerTap: onMarkerTap,
                selectedShelter: selectedShelter,
              ),
            )
            .toList(),
        builder: _builder,
        size: Size(36.w, 36.w),
        maxClusterRadius: 100,
        fitBoundsOptions: const FitBoundsOptions(maxZoom: 20),
        showPolygon: false,
      );

  static Widget _builder(context, markers) => Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ShColors.sushi.withOpacity(0.8),
          shape: BoxShape.circle,
        ),
        child: Text(
          markers.length.toString(),
          style: GoogleFonts.poppins(fontSize: 12.sp, color: ShColors.black),
        ),
      );
}
