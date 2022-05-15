import 'package:equatable/equatable.dart';

class ShelterGeom extends Equatable {
  final String? type;
  final List<double> coordinates;

  ShelterGeom({
    this.type,
    required this.coordinates,
  });

  factory ShelterGeom.fromJson(Map<String, dynamic> json) => ShelterGeom(
        type: json["type"],
        coordinates: List<double>.from(
          json["coordinates"]?.map((x) => x.toDouble()) ?? [],
        ),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };

  @override
  List<Object?> get props => [type, coordinates];
}
