import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shelter/presentation/styles/styles.dart';

class ShPrimaryButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final Color color;

  const ShPrimaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color = ShColors.sushi,
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
        backgroundColor: color,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      );
}
