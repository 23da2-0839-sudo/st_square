import 'package:flutter_test/flutter_test.dart';
import 'package:st_square/app/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const STSquareApp());
  });
}
