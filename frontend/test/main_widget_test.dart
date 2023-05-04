import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';
import 'package:frontend/my_services.dart';
import 'package:frontend/views/utils/colors.dart';

void main() {
  group('MyApp', () {
    testWidgets('should initialize MyService on app start', (tester) async {
      await tester.pumpWidget(const MyApp());

      expect(MyService().isInitialized, isTrue);
    });

    testWidgets('should have a title', (tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.text('Canteen Management App'), findsOneWidget);
    });

    testWidgets('should have a theme', (tester) async {
      await tester.pumpWidget(const MyApp());

      final theme =
          Theme.of(tester.element(find.text('Canteen Management App')));

      expect(theme.primarySwatch, Colors.red);
      expect(theme.textTheme.titleLarge?.color, AppColor.primary);
      expect(theme.elevatedButtonTheme.style?.backgroundColor?.resolve({}),
          AppColor.orange);
    });

    testWidgets('should not show debug banner', (tester) async {
      await tester.pumpWidget(const MyApp());

      expect(tester.debugWidget(find.byType(Banner)), findsNothing);
    });
  });
}
