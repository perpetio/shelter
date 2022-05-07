import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:shelter/data/models/models.dart';

abstract class MapState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MapInitial extends MapState {}

class MapLoaded extends MapState {
  final LatLng initialCenter;
  final List<ShelterModel> shelters;

  MapLoaded({
    required this.initialCenter,
    required this.shelters,
  });

  @override
  List<Object?> get props => [initialCenter, shelters];
}
