import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_ride/app/app.dart';

void main() {
  testWidgets('UnionRideApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const UnionRideApp());
    expect(find.byType(UnionRideApp), findsOneWidget);

    // Dispose widget tree to cancel splash timer and repeat animations cleanly
    await tester.pumpWidget(const SizedBox());
  });
}