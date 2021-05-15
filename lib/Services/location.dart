import 'package:geolocator/geolocator.dart';

class Location {

  double latitude;
  double longitude;

  Future<void> getCurrentLocation() async {
      try { //wait for the current location.
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
        //assign those values in latitude and longitude variables;
        latitude = position.latitude;
       longitude = position.longitude;
      }
      catch(e){
        print(e);
      }
    }
  }

