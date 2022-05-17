import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

import 'models.dart';

class ShelterProperties extends Equatable {
  final String? moid;
  final String? id;
  final ShelterGeom? geom;
  final String? district;
  final String? holder;
  final String? location;
  final String? settlement;
  final String? streetType;
  final String? streetName;
  final String? housenumber;
  final String? entrance;
  final String? pavilion;
  final String? objectType;
  final String? ownership;
  final String? separatelyOrBuiltin;
  final double? area;
  final int? capacity;
  final double? x;
  final double? y;
  final dynamic editorId;
  final dynamic uid;
  final dynamic editorDate;

  LatLng? get point {
    final x = this.x;
    final y = this.y;
    if (x == null || y == null) return null;
    return LatLng(y, x);
  }

  const ShelterProperties({
    this.moid,
    this.id,
    this.geom,
    this.district,
    this.holder,
    this.location,
    this.settlement,
    this.streetType,
    this.streetName,
    this.housenumber,
    this.entrance,
    this.pavilion,
    this.objectType,
    this.ownership,
    this.separatelyOrBuiltin,
    this.area,
    this.capacity,
    required this.x,
    required this.y,
    this.editorId,
    this.uid,
    this.editorDate,
  });

  factory ShelterProperties.fromJson(Map<String, dynamic> json) =>
      ShelterProperties(
        moid: json["moid"]?.toString(),
        id: json["id_"],
        geom: ShelterGeom.fromJson(json["geom"] ?? {}),
        district: json["district"],
        holder: json["holder"],
        location: json["location_"],
        settlement: json["settlement"],
        streetType: json["street_type"],
        streetName: json["street_name"],
        housenumber: json["housenumber"]?.toString(),
        entrance: json["entrance"]?.toString(),
        pavilion: json["pavilion"]?.toString(),
        objectType: json["object_type"],
        ownership: json["ownership"],
        separatelyOrBuiltin: json["separately_or_builtin"],
        area: _parseDouble(json["area"]),
        capacity: _parseInt(json["capacity"]),
        x: _parseDouble(json["x"]),
        y: _parseDouble(json["y"]),
        editorId: json["editor_id"],
        uid: json["uid"],
        editorDate: json["editor_date"],
      );

  Map<String, dynamic> toJson() => {
        "moid": moid,
        "id_": id,
        "geom": geom?.toJson(),
        "district": district,
        "holder": holder,
        "location_": location,
        "settlement": settlement,
        "street_type": streetType,
        "street_name": streetName,
        "housenumber": housenumber,
        "entrance": entrance,
        "pavilion": pavilion,
        "object_type": objectType,
        "ownership": ownership,
        "separately_or_builtin": separatelyOrBuiltin,
        "area": area,
        "capacity": capacity,
        "x": x,
        "y": y,
        "editor_id": editorId,
        "uid": uid,
        "editor_date": editorDate,
      };

  static double? _parseDouble(json) {
    if (json == null) return null;
    if (json is String) return double.tryParse(json.replaceAll(',', '.'));
    return json.toDouble();
  }

  static int? _parseInt(json) {
    if (json == null) return null;
    if (json is String) return int.tryParse(json);
    return json;
  }

  @override
  List<Object?> get props => [
        moid,
        id,
        geom,
        district,
        holder,
        location,
        settlement,
        streetType,
        streetName,
        housenumber,
        entrance,
        pavilion,
        objectType,
        ownership,
        separatelyOrBuiltin,
        area,
        capacity,
        x,
        y,
        editorId,
        uid,
        editorDate,
      ];
}
