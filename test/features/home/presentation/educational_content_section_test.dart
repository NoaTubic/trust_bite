import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_safety/core/presentation/widgets/custom_app_bar.dart';
import 'package:food_safety/features/home/presentation/widgets/educational_content_section.dart';
import 'package:mockito/mockito.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Mock for WebViewController
class MockWebViewController extends Mock implements WebViewController {}

void main() {
  group('EducationalContentSection Widget Tests', () {
    testWidgets('displays all labels', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EducationalContentSection(),
          ),
        ),
      );

      expect(find.text('Healthy eating'), findsOneWidget);
      expect(find.text('Cooking'), findsOneWidget);
      expect(find.text('Food science'), findsOneWidget);
      expect(find.text('Consumer awareness'), findsOneWidget);
      expect(find.text('Where food comes from'), findsOneWidget);
    });

    testWidgets('navigates to WebViewPage on tap', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EducationalContentSection(),
          ),
        ),
      );

      await tester.tap(find.text('Healthy eating'));
      await tester.pumpAndSettle();

      expect(find.byType(WebViewPage), findsOneWidget);
    });
  });

  group('WebViewPage Widget Tests', () {
    testWidgets('loads the correct URL', (WidgetTester tester) async {
      final mockController = MockWebViewController();
      const testUrl =
          'https://www.foodafactoflife.org.uk/14-16-years/healthy-eating-14-16-years/';

      await tester.pumpWidget(
        MaterialApp(
          home: WebViewPage(url: testUrl),
        ),
      );

      // Verify WebViewController is initialized with the correct URL
      verify(mockController.loadRequest(Uri.parse(testUrl))).called(1);
    });

    testWidgets('displays CustomAppBar', (WidgetTester tester) async {
      const testUrl =
          'https://www.foodafactoflife.org.uk/14-16-years/healthy-eating-14-16-years/';

      await tester.pumpWidget(
        MaterialApp(
          home: WebViewPage(url: testUrl),
        ),
      );

      expect(find.byType(CustomAppBar), findsOneWidget);
    });

    testWidgets('displays WebViewWidget', (WidgetTester tester) async {
      const testUrl =
          'https://www.foodafactoflife.org.uk/14-16-years/healthy-eating-14-16-years/';

      await tester.pumpWidget(
        MaterialApp(
          home: WebViewPage(url: testUrl),
        ),
      );

      expect(find.byType(WebViewWidget), findsOneWidget);
    });
  });
}
