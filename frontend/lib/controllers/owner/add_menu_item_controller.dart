import 'package:frontend/models/menu.dart';
import 'package:frontend/views/owner/add_menu_item_screen.dart';

class AddMenuItemController {
  void addMenuItem(Menu menu) {}

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
