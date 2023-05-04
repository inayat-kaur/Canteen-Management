import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/views/general/forget_password.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {
  getInstance() {
    return MockSharedPreferences();
  }
}

void main() {
  group('ForgetPassword', () {
    late ForgetPassword forgetPassword;

    setUp(() {
      forgetPassword = ForgetPassword();
    });

    testWidgets('renders reset password screen', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: forgetPassword));
      expect(find.text('Reset Password'), findsOneWidget);
      expect(find.byType(TextField), findsWidgets);
    });
  });
}
