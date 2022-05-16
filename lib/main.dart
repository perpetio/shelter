import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('uk')],
      fallbackLocale: const Locale('uk'),
      child: const App(),
    ),
  );
}
