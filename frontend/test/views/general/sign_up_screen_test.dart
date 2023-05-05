import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/views/general/sign_up_screen.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {
  getInstance() {
    return MockSharedPreferences();
  }
}

void main() {
  group('Sign Up Screen', () {
    late SignUpScreen signUpScreen;

    setUp(() {
      signUpScreen = SignUpScreen();
    });

    testWidgets('checks signup screen', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: signUpScreen));
      expect(find.text('Login'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsWidgets);
      expect(find.byType(TextField), findsWidgets);
    });
  });
}
