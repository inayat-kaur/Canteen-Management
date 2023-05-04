import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/models/menu.dart';
import 'package:frontend/views/owner/edit_menu_item_screen.dart';

void main() {
  group('EditMenuItem widget', () {
    testWidgets('should render the menu item name',
        (WidgetTester tester) async {
      final menu = Menu(
          item: 'Burger',
          price: 100,
          availability: 'A',
          image: '',
          category: 'snacks',
          rating: 4,
          type: 0);

      await tester.pumpWidget(
        MaterialApp(
          home: EditMenuItem(menu: menu),
        ),
      );

      expect(find.text('Burger'), findsOneWidget);
    });

    testWidgets('should render the menu item price',
        (WidgetTester tester) async {
      final menu = Menu(
          item: 'Burger',
          price: 100,
          availability: 'A',
          image: '',
          category: 'snacks',
          rating: 4,
          type: 0);

      await tester.pumpWidget(
        MaterialApp(
          home: EditMenuItem(menu: menu),
        ),
      );

      expect(find.text('100'), findsOneWidget);
    });

    testWidgets('should render the menu item availability',
        (WidgetTester tester) async {
      final menu = Menu(
          item: 'Burger',
          price: 100,
          availability: 'A',
          image: '',
          category: 'snacks',
          rating: 4,
          type: 0);

      await tester.pumpWidget(
        MaterialApp(
          home: EditMenuItem(menu: menu),
        ),
      );

      expect(find.text('A'), findsOneWidget);
    });

    // testWidgets('should update the menu item price',
    //     (WidgetTester tester) async {
    //   final menu = Menu(
    //       item: 'Burger',
    //       price: 100,
    //       availability: 'A',
    //       image: '',
    //       category: 'snacks',
    //       rating: 4,
    //       type: 0);

    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: EditMenuItem(menu: menu),
    //     ),
    //   );

    //   // tap the edit button to enable edit mode
    //   await tester.tap(find.byIcon(Icons.edit).first);
    //   await tester.pump();

    //   // enter a new price value
    //   await tester.enterText(find.byType(TextField).first, '200');
    //   await tester.pump();

    //   // tap the save button to save the changes
    //   await tester.tap(find.byIcon(Icons.save).first);
    //   await tester.pump();

    //   // verify that the price value has been updated
    //   expect(find.text('200'), findsOneWidget);
    // });

    // testWidgets('should update the menu item availability',
    //     (WidgetTester tester) async {
    //   final menu = Menu(
    //       item: 'Burger',
    //       price: 100,
    //       availability: 'A',
    //       image: '',
    //       category: 'snacks',
    //       rating: 4,
    //       type: 0);

    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: EditMenuItem(menu: menu),
    //     ),
    //   );

    //   // tap the edit button to enable edit mode
    //   await tester.tap(find.byIcon(Icons.edit).at(1));
    //   await tester.pump();

    //   // select a new availability value
    //   await tester.tap(find.text('U').last);
    //   await tester.pumpAndSettle();

    //   // tap the save button to save the changes
    //   await tester.tap(find.byIcon(Icons.save).at(1));
    //   await tester.pump();

    //   // verify that the availability value has been updated
    //   expect(find.text('U'), findsOneWidget);
    // });
  });
}
