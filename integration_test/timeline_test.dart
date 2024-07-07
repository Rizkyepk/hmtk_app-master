import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hmtk_app/presentation/user/home.dart';
import 'package:hmtk_app/presentation/user/signin.dart';
import 'package:hmtk_app/utils/utils.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hmtk_app/main.dart' as app;

Future<void> pumpUntilVisible(WidgetTester tester, Finder finder,
    {Duration timeout = const Duration(seconds: 10)}) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    await tester.pump();
    if (finder.evaluate().isNotEmpty) return;
  }
  throw Exception('Widget not visible after $timeout');
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test Timeline page load time for specific ListView.builder',
      (WidgetTester tester) async {
    final stopwatch = Stopwatch();

    app.main();
    await tester.pumpAndSettle();

    final response = await fetchData("tester", "tester");
    final Map<String, dynamic> data = json.decode(response.body);

    await SaveData.saveAuth(data["auth"]);
    await tester.pumpAndSettle();

    await tester.pumpWidget(const MaterialApp(home: Home()));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('navigate_to_timeline_button')));
    await tester.pumpAndSettle();

    stopwatch.start();
    await pumpUntilVisible(
        tester, find.byKey(const Key('timeline_list_builder')));

    stopwatch.stop();

    print('Timeline page load time: ${stopwatch.elapsedMilliseconds} ms');
  });
}
