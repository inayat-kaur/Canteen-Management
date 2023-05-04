import 'package:flutter/material.dart';
import 'package:frontend/models/menu.dart';
import 'package:frontend/my_services.dart';
import 'package:frontend/urls.dart';
import 'package:http/http.dart';

class AddMenuItemController {
  void addNewMenuItem(Menu menu, context) async {
    MyService myService = MyService();
    String token = myService.getToken();
    Client client = Client();
    final response = await client.post(addMenuItem,
        headers: {'Authorization': 'Bearer $token'}, body: menu.toJson());
    client.close();
    if (response.statusCode == 201) {
      Navigator.of(context).pop();
    } else {
      print(response.body);
      throw Exception('Failed to add menu item');
    }
  }

  String? validateItemName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the item name';
    }
    return null;
  }

  String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the price';
    }
    return null;
  }
}
