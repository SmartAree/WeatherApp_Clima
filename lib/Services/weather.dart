import 'package:clima_weatherapp/Services/location.dart';
import 'package:clima_weatherapp/Services/networking.dart';

const apiKey = "2678bea8588d7def4e8513dfba1f555d";

class WeatherModel {


  Future<dynamic> getCityWeather (String cityName) async {
    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;

  }

  Future<dynamic> getWeatherLocation() async {
    //WE USE THE GEOLOCATOR PACKAGE TO GET THE LATITUDE AND LONGITUDE THAN WE PUT THAT INTO URL

    //location class object
    Location loca = Location();
    await loca.getCurrentLocation();

    //get current live latitude and longitude of the device.
    // latitude = loca.latitude;
    // longitude = loca.longitude;


    //THEN WE USE NETWORK HELPER TO GET THE DATA BY NETWORKING WITH THE OPEN WEATHER MAP.
    NetworkHelper helper = NetworkHelper("https://api.openweathermap.org/data/2.5/weather?lat=${loca.latitude}&lon=${loca.longitude}&appid=$apiKey&units=metric");

    //get back the weather data.
    //pass this data into location screen.
    var weatherData = await helper.getData();

    return weatherData;
}

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}