import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'presentation/app.dart';
import 'presentation/utils/strings.dart';

void main() {
  runApp(
    EasyLocalization(
      path: Strings.translationsPath,
      supportedLocales: const [Locale('en')],
      child: const App(),
    ),
  );
}
