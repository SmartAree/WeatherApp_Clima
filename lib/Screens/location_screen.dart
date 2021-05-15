import 'package:clima_weatherapp/Screens/city_screen.dart';
import 'package:clima_weatherapp/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:clima_weatherapp/Services/weather.dart';

//In location screen we displaying the weather information to the user


class LocationScreen extends StatefulWidget {

  //we gonna get the weather from the different sources.
  final weatherLocation;
  const LocationScreen({@required this.weatherLocation});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weather = WeatherModel(); // weatherModel object
  int temperature;
  String weatherIcon;
  String cityName;
  String weatherMsg;

  @override
  void initState() {
    super.initState();
//state object has a property called widget. which will point to its parent stateful widget.
    updateUI(widget.weatherLocation);
  }

  void updateUI(dynamic weatherData){
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMsg = 'Unable to find weather data.';
        cityName = '';
        return; //end the process
      }
     //get the api data value.
     double temp = weatherData['main']['temp'];
     temperature = temp.toInt(); //convert decimal into integer.
     weatherMsg = weather.getMessage(temperature);
     var condition = weatherData['weather'][0]['id']; //variable which works inside this method.
     weatherIcon = weather.getWeatherIcon(condition);
     cityName = weatherData['name'];
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/cloudy.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getWeatherLocation();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName =  await Navigator.push(context, MaterialPageRoute(builder: (context){return CityScreen();},),);

                      //fetch the current weather.
                      if (typedName != null) {
                        var weatherData = await weather.getCityWeather(typedName);
                        updateUI(weatherData);

                      }

                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      //emojies are processed exactly the same way as string
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMsg in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}