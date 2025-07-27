import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitak_machine/controller/news_controller.dart';
import 'package:jitak_machine/controller/weather_controller.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.put(WeatherController());
    final newsController = Get.put(NewsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather & News"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Weather Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              if (weatherController.isLoading.value) {
                return const CircularProgressIndicator();
              }
              return Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Temp: ${weatherController.weather.value}°C\n${weatherController.weather.value}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }),
          ),

          // News Section
          Expanded(
            child: Obx(() {
              if (newsController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: newsController.newsList.length,
                itemBuilder: (context, index) {
                  final news = newsController.newsList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news.title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          news.description,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
