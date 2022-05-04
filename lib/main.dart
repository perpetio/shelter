import 'package:flutter/material.dart';
import 'package:shelter/presentation/screens/map/map_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(
        title: 'Shelter',
        home: MapScreen(),
      );
}
