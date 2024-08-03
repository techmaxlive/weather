import 'package:geocoding/geocoding.dart';

class MockLocationService {
  Future<Map<String, dynamic>> getUserLocation(
      {Function? onPermissionGranted}) async {
    double mockLatitude = 11.073100;
    double mockLongitude = 77.005104;

    List<Placemark> placemarks =
        await placemarkFromCoordinates(mockLatitude, mockLongitude);
    String country = placemarks.first.isoCountryCode.toString().toLowerCase();

    return {
      'activegps': true,
      'latitude': mockLatitude,
      'longitude': mockLongitude,
      'country': country,
    };
  }
}
