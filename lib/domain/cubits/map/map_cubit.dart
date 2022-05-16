import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:shelter/data/models/models.dart';
import 'package:shelter/data/repositories/repositories.dart';

import 'map_state.dart';

final LatLng _lvivCityCenter = LatLng(49.841863, 24.031566);

class MapCubit extends Cubit<MapState> {
  final SheltersRepository sheltersRepository;
  final RoutesRepository routesRepository;

  MapCubit({
    required this.sheltersRepository,
    required this.routesRepository,
  }) : super(MapInitial());

  void loadMap() async {
    final shelters = await sheltersRepository.getShelters();
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
        emit(
          currentState.copyWith(
            showLocation: false,
            selectedShelter: currentState.selectedShelter,
            routePoints: currentState.routePoints,
          ),
        );
      } else {
        final location = await _getLocation();
        emit(
          currentState.copyWith(
            showLocation: location != null,
            moveToPoint: location,
            selectedShelter: currentState.selectedShelter,
            routePoints: currentState.routePoints,
          ),
        );
      }
    }
  }

  Future<void> selectShelter(ShelterModel shelter) async {
    final currentState = state;
    if (currentState is MapLoaded && !currentState.routeInProgress) {
      emit(currentState.copyWith(selectedShelter: shelter));
    }
  }

  void resetSelectedShelter() {
    final currentState = state;
    if (currentState is MapLoaded &&
        !currentState.routeInProgress &&
        currentState.selectedShelter != null) {
      emit(currentState.copyWith(selectedShelter: null));
    }
  }

  void buildRoute() async {
    final currentState = state;
    if (currentState is MapLoaded &&
        !currentState.routeInProgress &&
        currentState.selectedShelter != null) {
      List<LatLng>? routePoints;
      final userLocation = await _getLocation();
      final end = currentState.selectedShelter!.properties.point;
      if (userLocation != null && end != null) {
        routePoints = await routesRepository.getRoutePoints(
          start: userLocation,
          end: end,
        );
      }
      emit(
        currentState.copyWith(
          selectedShelter: currentState.selectedShelter,
          routePoints: routePoints,
        ),
      );
    }
  }

  void toggleRouteInProgress() {
    final currentState = state;
    if (currentState is MapLoaded) {
      emit(
        currentState.copyWith(
          selectedShelter: currentState.selectedShelter,
          routePoints: currentState.routePoints,
          routeInProgress: !currentState.routeInProgress,
        ),
      );
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
