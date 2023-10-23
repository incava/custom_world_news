import 'dart:convert';

import 'package:get/get.dart';

import '../model/news_response.dart';

class NewsService extends GetConnect {
  final String BASE_URL = "https://newsapi.org/v2";


  Future<List<NewsArticle>> getNews({
    required String apiKey,
    required String country,
    required String category,
    required String query,
  }) async {
    final queryParams = {
      'apiKey': apiKey,
      'country': country,
      'category': category,
      'q': query,
    };

    final response = await get('$BASE_URL/top-headlines', query: queryParams);

    if (response.status.hasError) {
      throw Exception('Failed to load news');
    }

    final newsResponse = NewsResponse.fromJson(response.body);
    return newsResponse.articles??[];
  }
}

