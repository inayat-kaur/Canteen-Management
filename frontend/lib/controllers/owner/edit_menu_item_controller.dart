import 'package:frontend/models/menu.dart';
import 'package:frontend/urls.dart';
import 'package:frontend/views/owner/edit_menu_item_screen.dart';
import 'package:http/http.dart';

import '../../my_services.dart';

class EditMenuItemController {
  updatePrice(String price, String item) async {
    MyService myServices = MyService();
    Client client = Client();
    String token = myServices.getToken();
    final response = await client.put(updateItemPrice(item), headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'price': price,
    });
    client.close();
    if (response.statusCode == 200) {
      return price;
    } else {
      throw Exception('Error updating price');
    }
  }

  updateAvailability(String availability, String item) async {
    MyService myServices = MyService();
    Client client = Client();
    String token = myServices.getToken();
    final response = await client.put(updateItemPrice(item), headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'availability': availability,
    });
    client.close();
    if (response.statusCode == 200) {
      return availability;
    } else {
      throw Exception('Error updating availability');
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
