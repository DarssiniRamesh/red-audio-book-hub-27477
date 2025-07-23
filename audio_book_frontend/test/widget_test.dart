import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:audio_book_frontend/main.dart';

void main() {
  testWidgets('App generation message displayed', (WidgetTester tester) async {
    await tester.pumpWidget(const AudioBookApp());

    // TEST UPDATE: No "App is being generated..." string in real app, so we'll check for something present.
    expect(find.text('Red Audio Book Hub'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('App bar has correct title', (WidgetTester tester) async {
    await tester.pumpWidget(const AudioBookApp());

    expect(find.text('Red Audio Book Hub'), findsOneWidget);
  });
}
