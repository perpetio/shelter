import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelter/presentation/styles/styles.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(_lightTheme);

  static final _lightTheme = ThemeData(
    brightness: Brightness.light,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ShColors.white,
      selectedItemColor: ShColors.sushi,
      unselectedItemColor: ShColors.boulder,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ShColors.alabaster.withOpacity(0.94),
      foregroundColor: ShColors.black,
    ),
  );

  static final _darkTheme = ThemeData(
    brightness: Brightness.dark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ShColors.mineShaft,
      selectedItemColor: ShColors.sushi,
      unselectedItemColor: ShColors.silver,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ShColors.mineShaft,
      foregroundColor: ShColors.white,
    ),
  );

  void toggleTheme() {
    emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
  }
}
