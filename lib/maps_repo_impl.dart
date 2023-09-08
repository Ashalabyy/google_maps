import 'package:google_maps/maps_repo.dart';
import 'package:geolocator/geolocator.dart';

class MapsRepoImp implements MapsRepo {
  LocationPermission? permission;
  @override
  Future<void> getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('please on location');
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
    print(position);
  }
}
