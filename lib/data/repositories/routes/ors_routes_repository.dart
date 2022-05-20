import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import 'package:shelter/data/sh_keys.dart';

import 'routes_repository.dart';

const String _directionsUrl = 'https://api.openrouteservice.org/v2/directions/';
const String _profile = 'foot-walking';

class ORSRoutesRepository implements RoutesRepository {
  final Dio dio = Dio(BaseOptions(connectTimeout: 5000, receiveTimeout: 3000));
  @override
  Future<List<LatLng>> getRoutePoints({
    required LatLng start,
    required LatLng end,
  }) async {
    try {
      final response = await dio.get(
        '$_directionsUrl$_profile',
        queryParameters: {
          'api_key': ShKeys.orsApiKey,
          'start': '${start.longitude},${start.latitude}',
          'end': '${end.longitude},${end.latitude}',
        },
      );
      List points = response.data['features'][0]['geometry']['coordinates'];
      final List<LatLng> polyPoints = [];
      for (int i = 0; i < points.length; i++) {
        polyPoints.add(LatLng(points[i][1], points[i][0]));
      }
      return polyPoints;
    } on DioError catch (e) {
      log(e.toString());
      return [];
    }
  }
}
