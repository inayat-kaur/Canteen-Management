import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/models/User.dart';

void main() {
  group('User tests', () {
    late User user;

    setUp(() {
      user = User(
        username: 'john_doe',
        role: 0,
        name: 'John Doe',
        phone: '1234567890',
        password: 'password123',
      );
    });

    test('fromJson sets correct values', () {
      final json = {
        'username': 'jane_doe',
        'role': 1,
        'name': 'Jane Doe',
        'phone': '0987654321',
        'password': 'secret123',
      };
      user.fromJson(json);
      expect(user.username, equals('jane_doe'));
      expect(user.role, equals(1));
      expect(user.name, equals('Jane Doe'));
      expect(user.phone, equals('0987654321'));
      expect(user.password, equals('secret123'));
    });

    test('toJson returns correct values', () {
      final json = user.toJson();
      expect(json['username'], equals('john_doe'));
      expect(json['role'], equals('0'));
      expect(json['name'], equals('John Doe'));
      expect(json['phone'], equals('1234567890'));
      expect(json['password'], equals('password123'));
    });
  });
}
