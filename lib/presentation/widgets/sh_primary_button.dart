import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shelter/presentation/styles/styles.dart';

class ShPrimaryButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final bool primary;

  const ShPrimaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.primary = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onPressed,
        child: _label(),
        style: _style(),
      );

  Widget _label() => Text(
        label,
        style: GoogleFonts.poppins(
          color: ShColors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
        ),
      );

  ButtonStyle _style() => TextButton.styleFrom(
        fixedSize: Size(double.infinity, 42.h),
        backgroundColor: primary ? ShColors.sushi : ShColors.coral,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      );
}
