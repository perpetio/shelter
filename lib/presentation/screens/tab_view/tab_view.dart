import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shelter/presentation/screens/screens.dart';
import 'package:shelter/presentation/utils/strings.dart';

class TabView extends StatelessWidget {
  const TabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => PersistentTabView(
        context,
        screens: _screens(),
        items: _items(context),
        navBarHeight: 60.h,
        backgroundColor: _navBarTheme(context).backgroundColor!,
        padding: const NavBarPadding.symmetric(horizontal: 0),
        navBarStyle: NavBarStyle.simple,
      );

  List<Widget> _screens() => [
        const MapScreen(),
        const AddShelterScreen(),
        const SettingsScreen(),
      ];

  List<PersistentBottomNavBarItem> _items(BuildContext context) => [
        _navBarItem(context, icon: Icons.map_outlined, title: Strings.map),
        _navBarItem(
          context,
          icon: Icons.add_circle_outline,
          title: Strings.addShelter,
        ),
        _navBarItem(context, icon: Icons.settings, title: Strings.settings),
      ];

  PersistentBottomNavBarItem _navBarItem(
    context, {
    required IconData icon,
    required String title,
  }) =>
      PersistentBottomNavBarItem(
        icon: Icon(icon, size: 24.r),
        title: title,
        activeColorPrimary: _navBarTheme(context).selectedItemColor!,
        inactiveColorPrimary: _navBarTheme(context).unselectedItemColor!,
        textStyle: GoogleFonts.poppins(fontSize: 10.sp),
      );

  BottomNavigationBarThemeData _navBarTheme(BuildContext context) =>
      Theme.of(context).bottomNavigationBarTheme;
}
