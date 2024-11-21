import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:testproject/home_data.dart';

class HomeController extends GetxController {

  var users = <Data>[].obs;
  var selectedFirstName = ''.obs;
  var selectedLastName = ''.obs;


  var userCounts = <String, int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }


  Future<void> fetchData() async {
    final response = await http.get(Uri.parse("https://reqres.in/api/users"));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var homePageData = HomePageData.fromJson(jsonResponse);
      users.value = homePageData.data ?? [];
    } else {
      throw Exception("Failed to load data");
    }
  }

  void incrementCount() {
    if (selectedFirstName.isNotEmpty && selectedLastName.isNotEmpty) {
      String key = '${selectedFirstName.value} ${selectedLastName.value}';
      if (userCounts.containsKey(key)) {
        userCounts[key] = userCounts[key]! + 1;
      } else {
        userCounts[key] = 1;
      }
    }
  }
}
