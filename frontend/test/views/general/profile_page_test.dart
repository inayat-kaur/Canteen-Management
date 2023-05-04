import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/my_services.dart';
import 'package:mockito/mockito.dart';

class MockMyService extends Mock implements MyService {}

void main() {
  group('Profile', () {
    MockMyService mockMyService = MockMyService();

    setUp(() {
      mockMyService = MockMyService();
      WidgetsFlutterBinding.ensureInitialized();
    });

    test('getProfile should return a user object', () async {
      // Arrange
      final expectedUser = User(
          role: 1,
          name: 'John Doe',
          username: 'johndoe@example.com',
          phone: '0123456789',
          password: 'password');
      when(mockMyService.getProfile()).thenReturn(expectedUser);

      // Act
      final user = mockMyService.getProfile();

      // Assert
      expect(user, equals(expectedUser));
    });
  });
}
