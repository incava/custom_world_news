import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/model/news_response.dart';
import '../../../data/service/news_service.dart';

class HomeController extends GetxController {
  final NewsService newsService = NewsService(); // NewsService 인스턴스 생성
  final filterTextController = TextEditingController();
  final apiKey = '9aba52aee4e74e59bfb3558fb800f5bb';
  final newsList = <NewsArticle>[].obs; // 뉴스 아티클 목록을 RxList로 정의
  static const List<String> countries = ['kr', 'us', 'jp'];
  static const List<String> categories = ['general','business', 'entertainment','health','science','sports','technology'];
  final country = countries[0].obs;
  final category = categories[0].obs;
  var query = ''.obs;
  var isNewsLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    //fetchNews();
  }


  void setSelectedCountry(String? newValue) {
    country.value = newValue ?? "";
  }

  void setSelectedCategoryText(String newValue) {
    category.value = newValue;
  }

  void setFilterText(String newValue) {
    query.value = newValue;
  }


  void fetchNews() async {
    // News를 받아오기 위한 메서드
    try {
      isNewsLoading.value = true;
      final response = await newsService.getNews(
        apiKey: apiKey,
        country: country.value,
        category: category.value,
        query: query.value,
      );
      print(response);
      newsList.assignAll(response); // 데이터를 RxList에 할당
        } catch (e) {
      print('Failed to load news: $e');
    }finally{
      isNewsLoading.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
