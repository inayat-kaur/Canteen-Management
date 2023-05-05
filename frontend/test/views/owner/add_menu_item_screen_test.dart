import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/models/menu.dart';
import 'package:frontend/controllers/owner/add_menu_item_controller.dart';
import 'package:frontend/views/owner/add_menu_item_screen.dart';

void main() {
  testWidgets('has an item image field', (WidgetTester tester) async {
    // Build the widget tree
    await tester
        .pumpWidget(MaterialApp(home: AddMenuItem(category: 'appetizers')));

    // Find the TextFormField widget with the item image label
    final itemImageField =
        find.widgetWithText(TextFormField, 'Item Image Link');

    // Expect that the widget is present in the tree
    expect(itemImageField, findsOneWidget);
  });

  testWidgets('has a price field', (WidgetTester tester) async {
    // Build the widget tree
    await tester
        .pumpWidget(MaterialApp(home: AddMenuItem(category: 'appetizers')));

    // Find the TextFormField widget with the price label
    final priceField = find.widgetWithText(TextFormField, 'Price');

    // Expect that the widget is present in the tree
    expect(priceField, findsOneWidget);
  });
}
