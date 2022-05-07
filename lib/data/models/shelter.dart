import 'models.dart';

class ShelterModel {
  final String? type;
  final ShelterGeom? geometry;
  final ShelterProperties properties;

  ShelterModel({
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
}
