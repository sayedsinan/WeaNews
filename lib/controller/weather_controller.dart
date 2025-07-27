import 'dart:convert';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../model/weather_model.dart';

class WeatherController extends GetxController {
  final weather = Rxn<WeatherModel>();
  final isLoading = false.obs;

  final String _apiKey = '3e63a636b84f6d3fac10762d7632a0e0';

  @override
  void onInit() {
    super.onInit();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    try {
      isLoading.value = true;

      // Request permission first
      await _handleLocationPermission();

      // Get position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final url =
          'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$_apiKey&units=metric';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        weather.value = WeatherModel.fromJson(data);
      } else {
        Get.snackbar("Error", "Failed to load weather");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _handleLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permission permanently denied");
    }
  }
}
