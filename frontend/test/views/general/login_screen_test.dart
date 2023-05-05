import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/views/general/login_screen.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {
  getInstance() {
    return MockSharedPreferences();
  }
}

void main() {
  group('Login Screen', () {
    late LoginScreen loginScreen;

    setUp(() {
      loginScreen = LoginScreen();
    });

    testWidgets('checks login screen', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: loginScreen));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(TextField), findsWidgets);
    });
  });
}
