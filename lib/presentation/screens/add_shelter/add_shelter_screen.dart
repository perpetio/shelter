import 'package:flutter/material.dart';

class AddShelterScreen extends StatefulWidget {
  const AddShelterScreen({Key? key}) : super(key: key);

  @override
  State<AddShelterScreen> createState() => _AddShelterScreenState();
}

class _AddShelterScreenState extends State<AddShelterScreen> {
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text('add shelter'));
}
