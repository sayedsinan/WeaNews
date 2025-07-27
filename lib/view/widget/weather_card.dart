import 'package:flutter/material.dart';
import 'package:jitak_machine/model/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel? weather;
  final String bgImage;

  const WeatherCard({
    Key? key,
    required this.weather,
    required this.bgImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(bgImage),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: weather == null
          ? const Text(
              'No weather data',
              style: TextStyle(color: Colors.white),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  weather!.city,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Temperature: ${weather!.temperature}°C',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Condition: ${weather!.description}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
    );
  }
}
