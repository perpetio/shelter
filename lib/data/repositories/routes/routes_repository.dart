import 'package:latlong2/latlong.dart';

abstract class RoutesRepository {
  Future<List<LatLng>> getRoutePoints({
    required LatLng start,
    required LatLng end,
  });
}
