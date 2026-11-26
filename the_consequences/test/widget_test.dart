import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_consequences/app/app.dart';

void main() {
  testWidgets('App builds without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: TheConsequenceApp()));
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();
    expect(find.byType(TheConsequenceApp), findsOneWidget);
  });
}
