import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shelter/data/models/models.dart';
import 'package:shelter/presentation/styles/styles.dart';
import 'package:shelter/presentation/utils/strings.dart';
import 'package:shelter/presentation/widgets/sh_primary_button.dart';

class ShelterCard extends StatelessWidget {
  final ShelterProperties properties;
  final void Function() goToShelter;

  const ShelterCard({
    Key? key,
    required this.properties,
    required this.goToShelter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: 343.w,
        height: 204.h,
        decoration: _decoration(context),
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            _shelterText(context),
            SizedBox(height: 8.h),
            _address(context),
            SizedBox(height: 2.h),
            _shelterType(context),
            SizedBox(height: 13.h),
            if (properties.area != null) _area(context),
            const Spacer(),
            ShPrimaryButton(
              label: Strings.goToShelter,
              onPressed: () {},
            ),
          ],
        ),
      );

  Decoration _decoration(BuildContext context) => BoxDecoration(
        color: _colorScheme(context).background,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ShColors.black.withOpacity(0.1),
            blurRadius: 4.r,
            offset: Offset(0, 4.h),
          ),
        ],
      );

  Widget _shelterText(BuildContext context) => Text(
        Strings.shelter,
        style: _secondaryTextStyle(context),
      );

  ColorScheme _colorScheme(BuildContext context) =>
      Theme.of(context).colorScheme;

  TextStyle _secondaryTextStyle(BuildContext context) => GoogleFonts.poppins(
        color: _colorScheme(context).onSurface,
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
      );

  Widget _address(BuildContext context) => Text(
        '${properties.streetType ?? ''} ${properties.streetName ?? ''}, '
        '${properties.housenumber ?? ''}',
        style: GoogleFonts.poppins(
          color: _colorScheme(context).onBackground,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _shelterType(BuildContext context) => Text(
        properties.objectType ?? '',
        style: _secondaryTextStyle(context),
      );

  Widget _area(BuildContext context) => Row(
        children: [
          SvgPicture.asset(ShIcons.area, width: 16.w, height: 16.w),
          SizedBox(width: 2.w),
          Text(
            properties.area.toString() + ' ' + Strings.squareMeters,
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: _colorScheme(context).onBackground,
            ),
          ),
        ],
      );
}
