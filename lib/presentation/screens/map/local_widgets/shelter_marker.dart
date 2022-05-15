import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelter/data/models/models.dart';
import 'package:shelter/presentation/styles/styles.dart';

import 'triangle_clipper.dart';

class ShelterMarker {
  static Marker marker(
    ShelterModel shelter, {
    required void Function(ShelterModel) onMarkerTap,
    ShelterModel? selectedShelter,
  }) =>
      Marker(
        point: shelter.properties.point!,
        builder: shelter == selectedShelter
            ? _selectedBuilder
            : (context) => _builder(context, onTap: () => onMarkerTap(shelter)),
        width: shelter == selectedShelter ? 32.w : 24.w,
        height: shelter == selectedShelter ? 38.w : 28.5.w,
        anchorPos: AnchorPos.align(AnchorAlign.top),
      );

  static Widget _builder(
    BuildContext context, {
    required void Function() onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: _pin(),
      );

  static Widget _selectedBuilder(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: ShColors.sushi, blurRadius: 20.r)],
        ),
        child: _pin(selected: true),
      );

  static Widget _pin({bool selected = false}) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            width: selected ? 32.w : 24.w,
            height: selected ? 32.w : 24.w,
            decoration: BoxDecoration(
              color: ShColors.downy,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: FaIcon(
              FontAwesomeIcons.personShelter,
              size: selected ? 20.w : 15.w,
              color: ShColors.black,
            ),
          ),
          ClipPath(
            clipper: TriangleClipper(),
            child: Container(
              width: selected ? 10.w : 8.w,
              height: selected ? 6.w : 4.5.w,
              color: ShColors.downy,
            ),
          )
        ],
      );
}
