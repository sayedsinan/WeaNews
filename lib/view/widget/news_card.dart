import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitak_machine/controller/news_controller.dart';
import 'package:jitak_machine/model/news_model.dart';
import 'package:jitak_machine/view/news_details.dart';

class NewsCard extends StatelessWidget {
  final NewsArticle news;

  const NewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final NewsController controller = Get.find<NewsController>();

    return GestureDetector(
      onTap: () {
        Get.to(() => NewsDetailsView(news: news));
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                news.urlToImage != null
                    ? ClipRRect(
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.network(
                          news.urlToImage!,
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: Center(child: Icon(Icons.image, size: 30)),
                      ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Obx(() {
                    bool isFav = controller.isFavorite(news);
                    return GestureDetector(
                      onTap: () => controller.toggleFavorite(news),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.grey,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                news.title ?? "No Title",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                news.description ?? "No Description",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
