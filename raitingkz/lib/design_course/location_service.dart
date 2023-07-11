import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationService {
  final defLocation = const LatLng(43.238949, 76.889709);

  @override
  Future<LatLng> getCurrentLocation() async {
    return Geolocator.getCurrentPosition().then((value) {
      return LatLng(value.latitude, value.longitude);
    }).catchError(
      (_) => defLocation,
    );
  }

  @override
  Future<bool> checkPermission() {
    return Geolocator.checkPermission()
        .then((value) =>
            value == LocationPermission.always ||
            value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }

  @override
  Future<bool> requestPermission() {
    return Geolocator.requestPermission()
        .then((value) =>
            value == LocationPermission.always ||
            value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }
}
