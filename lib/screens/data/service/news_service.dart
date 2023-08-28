import 'dart:convert';

import 'package:flutter_application_4/screens/data/models/news_model.dart';
import 'package:http/http.dart' as http;

class NewsService {
  Future<News?> fetchNews(String key) async {
    Map<String, String>? headersKey = {
      "X-Api-Key": "5733eb82f6304e8f8dce26f6fd0ea8fd",
      "apiKey": "5733eb82f6304e8f8dce26f6fd0ea8fd",
    };
    http.Response response = await http.get(
        Uri.parse("https://newsapi.org/v2/everything?q=$key"),
        headers: headersKey);

    if (response.statusCode != 200) {
      throw Exception("Error");
    }
    final decoded = jsonDecode(response.body);
    News news = News.fromJson(decoded);
    return news;
  }
}
