import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/views/general/landing_screen.dart';

void main() {
  testWidgets("Check landing page", (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: MediaQueryData(),
            child: LandingScreen(),
          ),
        ),
      ),
    );
    final appNameFinder = find.text("zeroWait");
    expect(appNameFinder, findsOneWidget);
    final loginButtonFinder = find.text("Login");
    expect(loginButtonFinder, findsOneWidget);
    final signUpButtonFinder = find.text("Create An Account");
    expect(signUpButtonFinder, findsOneWidget);
  });
}
