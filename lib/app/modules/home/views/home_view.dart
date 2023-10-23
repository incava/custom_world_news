import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: Column(
        children: [
          // 여기에 필터 위젯 추가
          Row(
            children: [
              Spacer(),
              Text('국가: ',style: TextStyle(fontSize: 18),),
              Obx(() {
                return DropdownButton<String>(
                  value: controller.country.value, // 선택된 국가 값
                  items: HomeController.countries.map((country) {
                    return DropdownMenuItem<String>(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    controller.setSelectedCountry(newValue); // 국가 선택 시 상태 업데이트
                  },
                );
              }),
              Spacer(),
              Text('카테고리: ',style: TextStyle(fontSize: 18),),
              Obx(() {
                return DropdownButton<String>(
                  value: controller.category.value, // 선택된 국가 값
                  items: HomeController.categories.map((country) {
                    return DropdownMenuItem<String>(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    controller.setSelectedCountry(newValue); // 국가 선택 시 상태 업데이트
                  },
                );
              }),
              Spacer(),
              TextButton(
                  onPressed: () => controller.fetchNews(), child: Text("조회")),
              Spacer(),
            ],
          ),
          Obx(() {
            if (controller.isNewsLoading.value == true) {
               return CircularProgressIndicator();
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.newsList.length,
                  itemBuilder: (context, index) {
                    final newsArticle = controller.newsList[index];
                    return ListTile(
                      title: Text("${newsArticle.title}"),
                      subtitle: Text("${newsArticle.publishedAt}"),
                      onTap: () {
                        // 뉴스 항목을 탭했을 때 처리할 로직 추가
                      },
                    );
                  },
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
