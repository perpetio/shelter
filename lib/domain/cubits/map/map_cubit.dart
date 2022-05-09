import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:shelter/data/repositories/shelters/shelters_repository.dart';

import 'map_state.dart';

final LatLng _lvivCityCenter = LatLng(49.841863, 24.031566);

class MapCubit extends Cubit<MapState> {
  final SheltersRepository _repository;

  MapCubit(this._repository) : super(MapInitial());

  void loadMap() async {
    final shelters = await _repository.getShelters();
    final location = await _getLocation();
    emit(
      MapLoaded(
        initialCenter: location ?? _lvivCityCenter,
        shelters: shelters,
        showLocation: location != null,
      ),
    );
  }

  void toggleLocation() async {
    final currentState = state;
    if (currentState is MapLoaded) {
      if (currentState.showLocation) {
        emit(currentState.copyWith(showLocation: false));
      } else {
        final location = await _getLocation();
        emit(
          currentState.copyWith(
            showLocation: location != null,
            moveToPoint: location,
          ),
        );
      }
    }
  }

  Future<LatLng?> _getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (_denied(permission)) {
      permission = await Geolocator.requestPermission();
      if (_denied(permission)) return null;
    }
    final position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }

  bool _denied(LocationPermission permission) =>
      permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever;
}
