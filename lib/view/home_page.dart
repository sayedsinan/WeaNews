import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitak_machine/controller/login_controller.dart';
import 'package:jitak_machine/controller/news_controller.dart';
import 'package:jitak_machine/controller/weather_controller.dart';
import 'package:jitak_machine/view/widget/my_drawer.dart';
import 'package:jitak_machine/view/widget/news_card.dart';
import 'package:jitak_machine/view/widget/weather_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.find<WeatherController>();
    final newsController = Get.find<NewsController>();
    final loginController = Get.find<LoginController>();

    loginController.loadLoggedInUser();

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text("Weather & News"), centerTitle: true),
      drawer: MyAppDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // final isWideScreen = constraints.maxWidth > 600;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(() {
                  if (weatherController.isLoading.value) {
                    return const CircularProgressIndicator();
                  }

                  final weather = weatherController.weather.value;
                  final bgImage = weatherController
                      .getWeatherBackground(weather?.description);

                  return WeatherCard(
                    weather: weather,
                    bgImage: bgImage,
                  );
                }),
              ),
              Expanded(
                child: Obx(() {
                  if (newsController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (newsController.newsList.isEmpty) {
                    return const Center(child: Text("No news found."));
                  }

                  int crossAxisCount = 2;
                  if (screenWidth > 900) {
                    crossAxisCount = 4;
                  } else if (screenWidth > 600) {
                    crossAxisCount = 3;
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: newsController.newsList.length,
                      itemBuilder: (context, index) {
                        final news = newsController.newsList[index];
                        return NewsCard(news: news);
                      },
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
