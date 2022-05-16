import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:shelter/data/models/models.dart';

abstract class MapState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MapInitial extends MapState {}

class MapLoaded extends MapState {
  final LatLng? initialCenter;
  final List<ShelterModel> shelters;
  final bool showLocation;
  final LatLng? moveToPoint;
  final ShelterModel? selectedShelter;
  final List<LatLng>? routePoints;
  final bool routeInProgress;

  MapLoaded({
    this.initialCenter,
    required this.shelters,
    this.showLocation = false,
    this.moveToPoint,
    this.selectedShelter,
    this.routePoints,
    this.routeInProgress = false,
  });

  MapLoaded copyWith({
    List<ShelterModel>? shelters,
    bool? showLocation,
    LatLng? moveToPoint,
    ShelterModel? selectedShelter,
    List<LatLng>? routePoints,
    bool? routeInProgress,
  }) =>
      MapLoaded(
        shelters: shelters ?? this.shelters,
        showLocation: showLocation ?? this.showLocation,
        moveToPoint: moveToPoint,
        selectedShelter: selectedShelter,
        routePoints: routePoints,
        routeInProgress: routeInProgress ?? this.routeInProgress,
      );

  @override
  List<Object?> get props => [
        initialCenter,
        shelters,
        showLocation,
        moveToPoint,
        selectedShelter,
        routePoints,
        routeInProgress,
      ];
}
