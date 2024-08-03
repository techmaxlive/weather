import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  Future<Map<String, dynamic>> getUserLocation({
    Function? onPermissionGranted,
  }) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (!(await Geolocator.isLocationServiceEnabled())) {
      await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return {'activegps': false, 'error': 'Location permissions are denied'};
      }
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        if (onPermissionGranted != null) {
          onPermissionGranted();
        }
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      String country = placemarks.first.isoCountryCode.toString().toLowerCase();

      return {
        'activegps': true,
        'latitude': position.latitude,
        'longitude': position.longitude,
        'country': country,
      };
    } else {
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return {
            'activegps': false,
            'error': 'Location permissions are denied'
          };
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return {
          'activegps': false,
          'error':
              'Location permissions are permanently denied, we cannot request permissions.'
        };
      }

      // If permission is granted, execute the callback if provided
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        if (onPermissionGranted != null) {
          onPermissionGranted();
        }
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      String country = placemarks.first.isoCountryCode.toString().toLowerCase();

      return {
        'activegps': true,
        'latitude': position.latitude,
        'longitude': position.longitude,
        'country': country,
      };
    }
  }
}
