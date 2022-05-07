import 'package:shelter/data/models/models.dart';

abstract class SheltersRepository {
  Future<List<ShelterModel>> getShelters();
}

