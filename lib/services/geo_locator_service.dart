import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    final Position position;


    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    do{
            permission = await Geolocator.requestPermission();

    }while( permission ==LocationPermission.denied || permission == LocationPermission.deniedForever );  
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    position =
        await Geolocator.getCurrentPosition(locationSettings: locationSettings);

    return position;
  }
}


  
