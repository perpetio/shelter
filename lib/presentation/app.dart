import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shelter/data/repositories/repositories.dart';
import 'package:shelter/domain/cubits/cubits.dart';

import 'screens/screens.dart';
import 'styles/styles.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: _repositoryProviders(context),
        child: MultiBlocProvider(
          providers: _cubitProviders(context),
          child: _app(context),
        ),
      );

  Widget _app(BuildContext context) => BlocBuilder<ThemeCubit, ThemeData>(
        builder: (_, theme) => ScreenUtilInit(
          designSize: DesignConfig.size,
          child: MaterialApp(
            title: 'Shelter',
            theme: theme,
            home: const TabView(),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          ),
        ),
      );

  List<RepositoryProvider> _repositoryProviders(BuildContext context) => [
        RepositoryProvider<SheltersRepository>(
          create: (_) => AssetShelterRepository(),
        ),
        RepositoryProvider<RoutesRepository>(
          create: (_) => ORSRoutesRepository(),
        ),
      ];

  List<BlocProvider> _cubitProviders(BuildContext context) => [
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<MapCubit>(
          create: (context) => MapCubit(
            sheltersRepository:
                RepositoryProvider.of<SheltersRepository>(context),
            routesRepository: RepositoryProvider.of<RoutesRepository>(context),
          ),
        ),
      ];
}
