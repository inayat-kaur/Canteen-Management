import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/menu.dart';
import '../../urls.dart';

class HomeController {
  Future<List<Menu>> fetchMenu(String token) async {
    final response = await http.get(
      getMenu,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> menuJson = json.decode(response.body);
      List<Menu> menu = [];
      menuJson.forEach((item) {
        menu.add(Menu.fromJson(item));
      });
      return menu;
    } else {
      throw Exception('Failed to fetch menu');
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
}
