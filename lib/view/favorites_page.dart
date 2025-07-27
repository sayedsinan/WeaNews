import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitak_machine/controller/news_controller.dart';
import 'package:jitak_machine/model/news_model.dart';
import 'package:jitak_machine/view/news_details.dart';

class FavoritesView extends StatelessWidget {
  FavoritesView({super.key});

  final NewsController controller = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: Obx(() {
        final favorites = controller.favoriteNews;

        if (favorites.isEmpty) {
          return const Center(child: Text("No favorite news added."));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final NewsArticle news = favorites[index];
            return GestureDetector(
              onTap: () => Get.to(() => NewsDetailsView(news: news)),
              child: Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    news.urlToImage != null
                        ? ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.network(
                              news.urlToImage!,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            height: 150,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                            ),
                            child: const Center(child: Icon(Icons.image, size: 40)),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            news.title ?? "No Title",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            news.description ?? "No Description",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
