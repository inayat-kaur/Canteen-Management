import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/controllers/owner/menu_page_controller.dart';
import 'package:frontend/models/menu.dart';

void main() {
  group('searchMenu', () {
    test('returns empty list when no menu items match', () {
      final menu = [
        Menu(
            item: 'Item 1',
            price: 10,
            availability: 'A',
            rating: 4,
            category: 'Category 1',
            type: 0,
            image: ''),
        Menu(
            item: 'Item 2',
            price: 8,
            availability: 'A',
            rating: 3,
            category: 'Category 2',
            type: 1,
            image: ''),
        Menu(
            item: 'Item 3',
            price: 12,
            availability: 'U',
            rating: 2,
            category: 'Category 3',
            type: 0,
            image: ''),
      ];
      final searchText = 'No match';

      final searchResults = searchMenu(menu, searchText);

      expect(searchResults, isEmpty);
    });

    test('returns only matching menu items', () {
      final menu = [
        Menu(
            item: 'Item 1',
            price: 10,
            availability: 'A',
            rating: 4,
            category: 'Category 1',
            type: 0,
            image: ''),
        Menu(
            item: 'Item 2',
            price: 8,
            availability: 'A',
            rating: 3,
            category: 'Category 2',
            type: 1,
            image: ''),
        Menu(
            item: 'Item 3',
            price: 12,
            availability: 'U',
            rating: 2,
            category: 'Category 3',
            type: 0,
            image: ''),
      ];
      final searchText = 'item';

      final searchResults = searchMenu(menu, searchText);

      expect(searchResults.length, 3);
      expect(searchResults[0].item, 'Item 1');
      expect(searchResults[1].item, 'Item 2');
    });

    test('ignores case when matching menu items', () {
      final menu = [
        Menu(
            item: 'Item 1',
            price: 10,
            availability: 'A',
            rating: 4,
            category: 'Category 1',
            type: 0,
            image: ''),
        Menu(
            item: 'Item 2',
            price: 8,
            availability: 'A',
            rating: 3,
            category: 'Category 2',
            type: 1,
            image: ''),
        Menu(
            item: 'Item 3',
            price: 12,
            availability: 'U',
            rating: 2,
            category: 'Category 3',
            type: 0,
            image: ''),
      ];
      final searchText = 'ItEm';

      final searchResults = searchMenu(menu, searchText);

      expect(searchResults.length, 3);
    });

    test(
        'filterMenuBasedOnCategory should return a list of menu items with matching category',
        () {
      List<Menu> menu = [
        Menu(
          item: 'Item 1',
          price: 10,
          availability: 'A',
          rating: 4,
          category: 'Category 1',
          type: 0,
          image: 'image1.jpg',
        ),
        Menu(
          item: 'Item 2',
          price: 15,
          availability: 'A',
          rating: 3,
          category: 'Category 2',
          type: 0,
          image: 'image2.jpg',
        ),
        Menu(
          item: 'Item 3',
          price: 12,
          availability: 'A',
          rating: 5,
          category: 'Category 1',
          type: 1,
          image: 'image3.jpg',
        ),
      ];

      List<Menu> filteredMenu = filterMenuBasedOnCategory(menu, 'category 1');

      expect(filteredMenu.length, 2);
      expect(filteredMenu[0].item, 'Item 1');
      expect(filteredMenu[1].item, 'Item 3');
    });
  });

  test('Returns empty list when menu is empty', () {
    final menu = <Menu>[];
    final filtered = filterMenuBasedOnType(menu, 0);
    expect(filtered, isEmpty);
  });

  test('Returns all menu items of type 0 when all items are of that type', () {
    final menu = [
      Menu(
        item: 'Burger',
        price: 5,
        availability: 'A',
        rating: 4,
        category: 'Fast food',
        type: 0,
        image: '',
      ),
      Menu(
        item: 'Fries',
        price: 2,
        availability: 'A',
        rating: 3,
        category: 'Fast food',
        type: 0,
        image: '',
      ),
    ];
    final filtered = filterMenuBasedOnType(menu, 0);
    expect(filtered, equals(menu));
  });

  test('Returns only menu items of type 1 when some items are of that type',
      () {
    final menu = [
      Menu(
        item: 'Burger',
        price: 5,
        availability: 'A',
        rating: 4,
        category: 'Fast food',
        type: 0,
        image: '',
      ),
      Menu(
        item: 'Steak',
        price: 10,
        availability: 'A',
        rating: 5,
        category: 'Meat',
        type: 1,
        image: '',
      ),
      Menu(
        item: 'Salad',
        price: 4,
        availability: 'A',
        rating: 2,
        category: 'Healthy',
        type: 0,
        image: '',
      ),
    ];
    final filtered = filterMenuBasedOnType(menu, 1);
    expect(filtered, equals([menu[1]]));
  });

  test('Returns empty list when no items are of the specified type', () {
    final menu = [
      Menu(
        item: 'Burger',
        price: 5,
        availability: 'A',
        rating: 4,
        category: 'Fast food',
        type: 0,
        image: '',
      ),
      Menu(
        item: 'Fries',
        price: 2,
        availability: 'A',
        rating: 3,
        category: 'Fast food',
        type: 0,
        image: '',
      ),
    ];
    final filtered = filterMenuBasedOnType(menu, 1);
    expect(filtered, isEmpty);
  });
}
