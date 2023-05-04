import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/controllers/owner/edit_menu_item_controller.dart';

void main() {
  test('validateItemName returns error message when value is null or empty',
      () {
    EditMenuItemController editMenuItemController = EditMenuItemController();
    // Test case 1: null value
    String? value = null;
    expect(editMenuItemController.validateItemName(value),
        'Please enter the item name');

    // Test case 2: empty string
    value = '';
    expect(editMenuItemController.validateItemName(value),
        'Please enter the item name');

    // Test case 3: non-empty string
    value = 'Pizza';
    expect(editMenuItemController.validateItemName(value), null);
  });

  EditMenuItemController editMenuItemController = EditMenuItemController();
  test('Empty price validation', () {
    expect(editMenuItemController.validatePrice(''), 'Please enter the price');
  });

  test('Null price validation', () {
    expect(
        editMenuItemController.validatePrice(null), 'Please enter the price');
  });

  test('Valid price', () {
    expect(editMenuItemController.validatePrice('10'), null);
  });
}
