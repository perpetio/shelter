import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'presentation/app.dart';
import 'presentation/utils/strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      path: Strings.translationsPath,
      supportedLocales: const [Locale('en')],
      fallbackLocale: const Locale('en'),
      child: const App(),
    ),
  );
}
