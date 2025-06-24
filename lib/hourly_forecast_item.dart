import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class HourlyForecastItem extends StatelessWidget{
  final String time;
  final IconData icon;
  final String tempressure;
  const HourlyForecastItem({
    super.key,
    required this.time,
    required this.icon,
    required this.tempressure,
  });

  @override
  Widget build(BuildContext context){
    return Card(
      elevation: 20,
      child: Container(
        width: 90,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80)
        ),
        child: Column(
          children: [
            Text(
              time,
                style: TextStyle(
                fontSize: 20
                ),
            ),
            BoxedIcon(
              icon,
              size: 30,
            ),
            SizedBox(height: 5),
            Text(
              tempressure,
                style: TextStyle(
                fontSize: 15,
                color: const Color.fromARGB(255, 168, 168, 167)
                ),
            ),
          ],
        ),
      ),
    );
  }
}