import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jitak_machine/model/news_model.dart';

class NewsController extends GetxController {
var favoriteNews = <NewsArticle>[].obs; // change from RxSet<String> to RxList<NewsArticle>
  final String apiKey = "942458d1c9c94996817ba9847e6b1420";
  var newsList = <NewsArticle>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }

  void toggleFavorite(NewsArticle article) {
    if (favoriteNews.contains(article)) {
      favoriteNews.remove(article);
    } else {
      favoriteNews.add(article);
    }
  }

  bool isFavorite(NewsArticle article) {
    return favoriteNews.contains(article);
  }
  Future<void> fetchNews() async {
    isLoading(true);
    final url =
        "https://newsapi.org/v2/everything?q=latest&sortBy=publishedAt&language=en&apiKey=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);

        if (data['status'] == "ok") {
          newsList.value =
              (data['articles'] as List)
                  .map((e) => NewsArticle.fromJson(e))
                  .toList();
        } else {
          print("News API error: ${data['message']}");
        }
      } else {
        print("HTTP error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching news: $e");
    } finally {
      isLoading(false);
    }
  }
}
