import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jitak_machine/model/news_model.dart';

class NewsController extends GetxController {
  var newsList = <NewsModel>[].obs;
  var isLoading = true.obs;

  final String apiKey = "942458d1c9c94996817ba9847e6b1420";

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

 Future<void> fetchNews() async {
  isLoading(true);
  final url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=$apiKey";

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == "ok") {
        newsList.value = (data['articles'] as List)
            .map((e) => NewsModel.fromJson(e))
            .toList();
      } else {
        print("News API responded with status: ${data['status']}");
      }
    } else {
      print("Failed to load news. Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error fetching news: $e");
  } finally {
    isLoading(false);
  }
}

}
