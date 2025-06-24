import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:weather_app/infomation.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
  try {
    String city = 'Yangon';
    final res = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$city,mm&APPID=$openWeatherKey'
      ),
    );
    final data = jsonDecode(res.body);

    if (data['cod'] != '200') {
      throw 'An Expected Error Happen';
    }
  //  data['list'][0]['main']['temp'];
     return data;
  } catch (e) {
    throw e.toString();
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              print('Refresh');
          },
          icon: Icon(Icons.refresh))
        ],
      ),
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: FutureBuilder(
          future: getCurrentWeather(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            // Variables
            final data = snapshot.data!;

            final currentWeatherData = data['list'][0];
            final currentTempressure = currentWeatherData['main']['temp'];
            final currentSky = currentWeatherData['weather'][0]['main'];
            final currentHumidity = currentWeatherData['main']['humidity'];
            final currentPressure = currentWeatherData['main']['pressure'];
            final currentWindSpeed = currentWeatherData['wind']['speed'];

            return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10
                          ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentTempressure°F',
                                 style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold
                                 ),
                                ),
                                SizedBox(height: 15),
                                BoxedIcon(
                                  currentSky == 'Clouds' || currentSky == 'Sunny'
                                  ? WeatherIcons.cloud
                                  : WeatherIcons.rain,
                                  size: 40,
                                ),
                                SizedBox(height: 15),
                              Text(
                                currentSky,
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                 Text(
                    'Weather Focus',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                const SizedBox(height: 20),
                // Weather Focus
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for(int i=0; i<39; i++)
                //       HourlyForecastItem(
                //         time: data['list'][i + 1]['dt'].toString(),
                //         icon: () {
                //         String condition = data['list'][i + 1]['weather'][0]['main'];
                //         if (condition == 'Clouds') return WeatherIcons.cloud;
                //         if (condition == 'Clear' || condition == 'Sunny') return WeatherIcons.day_sunny;
                //         if (condition == 'Rain') return WeatherIcons.rain;
                //         if (condition == 'Snow') return WeatherIcons.snow;
                //         if (condition == 'Fog' || condition == 'Mist') return WeatherIcons.fog;
                //         if (condition == 'Thunderstorm') return WeatherIcons.thunderstorm;
                //         return WeatherIcons.day_cloudy_high; // fallback
                //       }(),
                //         tempressure: data['list'][i + 1]['main']['temp'].toString(),
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(height: 20),
                // Additional Infomation
                Text(
                  'Additional Infomations',
                  style: TextStyle(
                    fontSize: 25
                  ),
                ),
                SizedBox(height: 20), 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Infomations(
                      icon: Icons.water_drop,
                      label: 'Humditiy',
                      value: currentHumidity.toString(),
                    ),
                    Infomations(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: currentWindSpeed.toString(),
                    ),
                    Infomations(
                      icon: Icons.beach_access,
                      label: 'Pressure',
                      value: currentPressure.toString(),
                    ),
                  ],
                )
              ],
            ),
          );
          },
        ),
      ),
    );
  }
}