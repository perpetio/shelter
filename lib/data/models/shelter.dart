import 'package:equatable/equatable.dart';

import 'models.dart';

class ShelterModel extends Equatable {
  final String? type;
  final ShelterGeom? geometry;
  final ShelterProperties properties;

  const ShelterModel({
    this.type,
    this.geometry,
    required this.properties,
  });

  factory ShelterModel.fromJson(Map<String, dynamic> json) => ShelterModel(
        type: json["type"],
        geometry: ShelterGeom.fromJson(json["geometry"] ?? {}),
        properties: ShelterProperties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "geometry": geometry?.toJson(),
        "properties": properties.toJson(),
      };

  @override
  List<Object?> get props => [type, geometry, properties];
}
