import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:shelter/data/repositories/shelters/shelters_repository.dart';

import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final SheltersRepository _repository;

  MapCubit(this._repository) : super(MapInitial());

  void loadShelters() async {
    final _lvivCityCenter = LatLng(49.841863, 24.031566); //TODO add logic
    final shelters = await _repository.getShelters();
    emit(MapLoaded(initialCenter: _lvivCityCenter, shelters: shelters));
  }
}
