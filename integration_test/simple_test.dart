// import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:your_app/main.dart' as app;
import 'package:hmtk_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Simple Test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    expect(find.text('Welcome'), findsOneWidget); // Adjust based on your app's initial screen
  });
}
