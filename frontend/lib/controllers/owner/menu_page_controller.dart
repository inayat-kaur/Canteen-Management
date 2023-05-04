import 'dart:convert';
import 'package:frontend/my_services.dart';
import 'package:http/http.dart';
import '../../models/menu.dart';
import '../../urls.dart';

Future<List<Menu>> fetchMenu() async {
  MyService myService = MyService();
  String token = myService.getToken();
  Client client = Client();
  final response = await client.get(getMenu, headers: {
    'Authorization': 'Bearer $token',
  });
  client.close();
  if (response.statusCode == 200) {
    final List<dynamic> menuJson = json.decode(response.body);
    List<Menu> menu = [];
    for (int i = 0; i < menuJson.length; i++) {
      menu.add(Menu.fromJson(menuJson[i]));
    }
    return menu;
  } else {
    throw Exception('Failed to fetch menu');
  }
}

Future<List<String>> fetchCategories(String token) async {
  Client client = Client();
  final response = await client.get(
    getCategories,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );
  client.close();
  print("getCategories called");
  print(response);
  if (response.statusCode == 200) {
    final List<dynamic> categoriesJson = json.decode(response.body);
    final List<String> categories =
        categoriesJson.map<String>((category) => category['category']).toList();
    print(categories);
    return categories;
  } else {
    print('Error: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to fetch categories');
  }
}

List<Menu> searchMenu(List<Menu> menu, String searchText) {
  List<Menu> searchResults = [];
  menu.forEach((menuItem) {
    if (menuItem.item.toLowerCase().contains(searchText.toLowerCase())) {
      searchResults.add(menuItem);
    }
  });
  return searchResults;
}

List<Menu> filterMenuBasedOnCategory(List<Menu> menu, String category) {
  List<Menu> filteredMenu = [];
  menu.forEach((menuItem) {
    if (menuItem.category.toLowerCase() == category.toLowerCase()) {
      filteredMenu.add(menuItem);
    }
  });

  return filteredMenu;
}

List<Menu> filterMenuBasedOnType(List<Menu> menu, int type) {
  List<Menu> filteredMenu = [];
  menu.forEach((menuItem) {
    if (menuItem.type == type) {
      filteredMenu.add(menuItem);
    }
  });
  return filteredMenu;
}
