// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../../models/menu.dart';
// import '../../urls.dart';
// import 'package:shared_preferences/shared_preferences.dart';

//     Future<List<Menu>> fetchMenu() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = await prefs.getString('token');
//     final response = await http.get(
//       getMenu,
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       final List<dynamic> menuJson = json.decode(response.body);
//       List<Menu> menu = [];
//       menuJson.forEach((item) {
//         menu.add(Menu.fromJson(item));
//       });
//       return menu;
//     } else {
//       throw Exception('Failed to fetch menu');
//     }
//   }
