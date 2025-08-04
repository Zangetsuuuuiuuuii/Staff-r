import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/pages/dashboard_page.dart'; // ✅ works locally for tests


void main() {
  testWidgets('Staffing App UI and category list test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: DashboardPage(),
    ));

    // Check for App title
    expect(find.text('Staffing App'), findsOneWidget);

    // Check for all category titles
    final categories = [
      "Security",
      "Housekeeping",
      "Driving",
      "Nursing",
      "Tutoring",
      "Reception",
    ];

    for (var category in categories) {
      expect(find.text(category), findsOneWidget, reason: 'Expected to find $category category');
    }
  });
}
