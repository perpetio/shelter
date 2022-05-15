import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelter/presentation/styles/styles.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(_lightTheme);

  static final _lightTheme = ThemeData(
    colorScheme: const ColorScheme(
      background: ShColors.white,
      brightness: Brightness.light,
      error: ShColors.coral,
      onBackground: ShColors.mineShaft,
      onError: ShColors.white,
      onPrimary: ShColors.white,
      onSecondary: ShColors.mineShaft,
      onSurface: ShColors.abbey,
      primary: ShColors.sushi,
      secondary: ShColors.white,
      surface: ShColors.white,
    ),
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
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      background: ShColors.mineShaft,
      error: ShColors.coral,
      onBackground: ShColors.white,
      onError: ShColors.white,
      onPrimary: ShColors.white,
      onSecondary: ShColors.white,
      onSurface: ShColors.alabaster,
      primary: ShColors.sushi,
      secondary: ShColors.mineShaft,
      surface: ShColors.mineShaft,
    ),
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
