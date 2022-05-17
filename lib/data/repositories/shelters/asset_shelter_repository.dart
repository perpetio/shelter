import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shelter/data/models/models.dart';

import 'shelters_repository.dart';

const String _jsonPath = 'assets/evacuation_lviv_region.json';

class AssetShelterRepository implements SheltersRepository {
  @override
  Future<List<ShelterModel>> getShelters() async {
    final jsonString = await rootBundle.loadString(_jsonPath);
    final data = jsonDecode(jsonString) as Map<String, dynamic>;
    return List<ShelterModel>.from(
      data['features'].map((item) => ShelterModel.fromJson(item)),
    );
  }
}
