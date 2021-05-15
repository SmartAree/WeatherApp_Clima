import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';
import 'package:clima_weatherapp/Services/weather.dart';

//In this screen we're fetching the location and weather data.



class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState(){
    super.initState();
    getLocationData();
    print('triggered');
  }

  void getLocationData() async {

    var weatherData = await WeatherModel().getWeatherLocation();



     Navigator.push(context, MaterialPageRoute(builder: (context){
       return LocationScreen(weatherLocation: weatherData,);
     }
     )
     );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 100.0,
        ),
      ),

    );
  }
}