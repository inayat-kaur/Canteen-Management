import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/controllers/owner/add_menu_item_controller.dart';

void main() {
  test('validateItemName returns error message when value is null or empty',
      () {
    AddMenuItemController addMenuItemController = AddMenuItemController();
    // Test case 1: null value
    String? value = null;
    expect(addMenuItemController.validateItemName(value),
        'Please enter the item name');

    // Test case 2: empty string
    value = '';
    expect(addMenuItemController.validateItemName(value),
        'Please enter the item name');

    // Test case 3: non-empty string
    value = 'Pizza';
    expect(addMenuItemController.validateItemName(value), null);
  });

  AddMenuItemController addMenuItemController = AddMenuItemController();
  test('Empty price validation', () {
    expect(addMenuItemController.validatePrice(''), 'Please enter the price');
  });

  test('Null price validation', () {
    expect(addMenuItemController.validatePrice(null), 'Please enter the price');
  });

  test('Valid price', () {
    expect(addMenuItemController.validatePrice('10'), null);
  });
}
