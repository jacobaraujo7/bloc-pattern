import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:exampleinjector/app/pages/login/login_page.dart';


main() {
  testWidgets('LoginPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(LoginPage(title: 'Login')));
    final titleFinder = find.text('Login');
    expect(titleFinder, findsOneWidget);
  });
}
