import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      );

  List<Widget> _screens() => [
        const MapScreen(),
        const AddShelterScreen(),
        const SettingsScreen(),
      ];

  List<PersistentBottomNavBarItem> _items(BuildContext context) => [
        _navBarItem(context, icon: Icons.map_outlined, title: Strings.map),
      ];

  PersistentBottomNavBarItem _navBarItem(
    context, {
    required IconData icon,
    required String title,
  }) =>
      PersistentBottomNavBarItem(
        icon: Icon(icon, size: 24.r),
        title: title,
        activeColorPrimary:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
        inactiveColorPrimary:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor!,
      );
}
