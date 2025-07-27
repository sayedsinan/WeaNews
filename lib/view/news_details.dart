import 'package:flutter/material.dart';
import 'package:jitak_machine/model/news_model.dart';

class NewsDetailsView extends StatelessWidget {
  final NewsArticle news;

  const NewsDetailsView({super.key, required this.news});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("News Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            news.urlToImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      news.urlToImage!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Center(child: Icon(Icons.image, size: 40)),
                  ),
            const SizedBox(height: 16),

            // Title
            Text(
              news.title ?? "No Title",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              softWrap: true,
            ),
            const SizedBox(height: 12),

            // Author and Date
            Row(
              children: [
                Expanded(
                  child: Text(
                    news.author ?? "Unknown Author",
                    style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  news.publishedAt?.split("T")[0] ?? "",
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              news.description ?? "No Description",
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),

           
          ],
        ),
      ),
    );
  }
}
