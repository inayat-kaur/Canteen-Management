import 'package:frontend/my_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/menu.dart';
import '../../urls.dart';

Future<List<Menu>> fetchMenu(String token) async {
  MyService myService = MyService();
  if (myService.getMyMenu().isNotEmpty) {
    return myService.getMyMenu();
  }
  final response = await http.get(
    getMenu,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );
  print("getMenu called");
  if (response.statusCode == 200) {
    final List<dynamic> menuJson = json.decode(response.body);
    List<Menu> menu = [];
    menuJson.forEach((item) {
      menu.add(Menu.fromJson(item));
    });
    print(menu);
    return menu;
  } else {
    throw Exception('Failed to fetch menu');
  }
}

Future<List<String>> fetchCategories(String token) async {
  MyService myService = MyService();
  if (myService.getMyMenu().isNotEmpty) {
    List<String> categories = [];
    List<Menu> mymenu = myService.getMyMenu();
    for (var item in mymenu) {
      if (!categories.contains(item.category)) {
        categories.add(item.category);
      }
    }
    return categories;
  }
  final response = await http.get(
    getCategories,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );
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
