import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:omnesoft_task/omnesoft_ui_foundations.dart';

import 'package:omnesoft_task/omnesoft_ui_foundations/test/test_app.dart';

void main() {
  group('omnesoft_ui_foundations widgets', () {
    testWidgets('OmnesoftScaffold renders body', (tester) async {
      await tester.pumpWidget(
        wrapWithTestApp(const OmnesoftScaffold(body: Text('Body'))),
      );

      expect(find.text('Body'), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('OmnesoftAppBar renders title and leading', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        wrapWithTestApp(
          Scaffold(
            appBar: OmnesoftAppBar(
              title: 'Title',
              leading: IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => tapped = true,
              ),
            ),
            body: const SizedBox(),
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.chevron_left));
      await tester.pump();
      expect(tapped, isTrue);
    });

    testWidgets('OmnesoftTextField shows hint and accepts text', (
      tester,
    ) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        wrapWithTestApp(
          OmnesoftTextField(controller: controller, hintText: 'Search'),
        ),
      );

      expect(find.text('Search'), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'abc');
      await tester.pump();
      expect(controller.text, 'abc');
    });

    testWidgets('OmnesoftCachedNetworkImage shows skeleton placeholder', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrapWithTestApp(
          const OmnesoftCachedNetworkImage(
            imageUrl: 'https://example.com/image.png',
            width: 40,
            heigtht: 40,
          ),
        ),
      );

      final containers = tester.widgetList<Container>(find.byType(Container));
      final hasGradientDecoration = containers.any((c) {
        final decoration = c.decoration;
        return decoration is BoxDecoration && decoration.gradient != null;
      });

      expect(hasGradientDecoration, isTrue);
    });
  });
}
