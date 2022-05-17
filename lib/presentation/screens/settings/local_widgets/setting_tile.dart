import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shelter/presentation/styles/styles.dart';

class SettingTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final Widget? trailing;

  const SettingTile({
    Key? key,
    required this.iconPath,
    required this.title,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 42.h,
        child: Row(
          children: [
            SvgPicture.asset(iconPath, width: 24.w, height: 24.w),
            SizedBox(width: 16.w),
            _title(context),
            const Spacer(),
            if (trailing != null) trailing!,
          ],
        ),
      );

  Widget _title(BuildContext context) => Text(
        title,
        style: GoogleFonts.poppins(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      );
}
