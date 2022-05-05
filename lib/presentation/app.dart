import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shelter/domain/cubits/cubits.dart';

import 'screens/map/map_screen.dart';
import 'styles/styles.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: _cubitProviders(context),
        child: _app(),
      );

  Widget _app() => BlocBuilder<ThemeCubit, ThemeData>(
        builder: (_, theme) => ScreenUtilInit(
          designSize: DesignConfig.size,
          child: MaterialApp(
            title: 'Shelter',
            theme: theme,
            home: const MapScreen(),
          ),
        ),
      );

  List<BlocProvider> _cubitProviders(BuildContext context) => [
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
      ];
}
