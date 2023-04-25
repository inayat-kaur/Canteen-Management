import 'package:frontend/models/menu.dart';
import 'package:frontend/views/owner/edit_menu_item_screen.dart';

class EditMenuItemController {
  void editMenuItem(Menu menu) {}

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
