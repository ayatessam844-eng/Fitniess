import 'package:fitnies/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('shows onboarding before login on first launch', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const ProviderScope(child: FitnessApp()));

    await tester.pumpAndSettle();

    expect(find.text('Train with purpose'), findsOneWidget);
    expect(find.text('Get started'), findsNothing);
  });

  testWidgets('shows login after onboarding is complete', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({'has_seen_onboarding': true});

    await tester.pumpWidget(const ProviderScope(child: FitnessApp()));

    await tester.pumpAndSettle();

    expect(find.text('Log in'), findsOneWidget);
  });
}
