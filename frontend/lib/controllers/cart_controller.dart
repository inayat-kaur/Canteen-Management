import 'package:http/http.dart' as http;
import '../models/menu.dart';
import 'dart:convert';
import './../urls.dart';

class CartController{
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
}