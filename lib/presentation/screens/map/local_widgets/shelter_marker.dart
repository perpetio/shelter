import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:shelter/presentation/styles/styles.dart';

import 'triangle_clipper.dart';

class ShelterMarker {
  static Marker marker(LatLng point) => Marker(
        point: point,
        builder: _builder,
        width: 24.w,
        height: 28.5.w,
        anchorPos: AnchorPos.align(AnchorAlign.top),
      );

  static Widget _builder(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: ShColors.downy,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: FaIcon(
              FontAwesomeIcons.personShelter,
              size: 15.w,
              color: ShColors.black,
            ),
          ),
          ClipPath(
            clipper: TriangleClipper(),
            child: Container(width: 8.w, height: 4.5.w, color: ShColors.downy),
          )
        ],
      );
}
