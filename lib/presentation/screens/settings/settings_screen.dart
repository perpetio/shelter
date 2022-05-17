import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shelter/domain/cubits/cubits.dart';
import 'package:shelter/presentation/styles/styles.dart';
import 'package:shelter/presentation/utils/strings.dart';

import 'local_widgets/setting_tile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) => Container(
        color: _colorScheme(context).background,
        padding: EdgeInsets.all(25.r),
        child: Column(
          children: [
            SizedBox(height: 30.h),
            _title(),
            SizedBox(height: 40.h),
            _darkModeTile(context),
          ],
        ),
      );

  ColorScheme _colorScheme(BuildContext context) =>
      Theme.of(context).colorScheme;

  Widget _title() => Text(
        Strings.settings,
        style: GoogleFonts.poppins(
          color: _colorScheme(context).onBackground,
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _darkModeTile(BuildContext context) => SettingTile(
        iconPath: ShIcons.moon,
        title: Strings.darkMode,
        trailing: _darkModeSwitch(context),
      );

  Widget _darkModeSwitch(BuildContext context) => SizedBox(
        width: 40.w,
        height: 28.h,
        child: FittedBox(
          fit: BoxFit.fill,
          child: CupertinoSwitch(
            value: _colorScheme(context).brightness == Brightness.dark,
            onChanged: (_) {
              BlocProvider.of<ThemeCubit>(context).toggleTheme();
            },
          ),
        ),
      );
}
