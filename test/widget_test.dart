import 'package:flutter_test/flutter_test.dart';
import 'package:archon/app.dart';

void main() {
  testWidgets('ARCHON app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const ArchonApp());

    expect(find.text('ARCHON'), findsWidgets);
  });
}