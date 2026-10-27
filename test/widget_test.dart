import 'package:cashkada/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the CashKada branded header and bottom nav',
      (tester) async {
    await tester.pumpWidget(const CashKadaApp());
    await tester.pump();

    expect(find.text('cashkada'), findsOneWidget);
    expect(find.text('Safe. Fast. Convenient.'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Pay'), findsOneWidget);
    expect(find.text('Send'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
    expect(find.text('Wallet'), findsOneWidget);
  });

  testWidgets('requires valid payment details before review', (tester) async {
    await tester.pumpWidget(const CashKadaApp());
    await tester.pump();

    await tester.tap(find.text('Pay'));
    await tester.pump();

    await tester.ensureVisible(find.text('Continue to review'));
    await tester.tap(find.text('Continue to review'));
    await tester.pump();

    expect(find.text('Select a network provider'), findsOneWidget);
    expect(find.textContaining('valid 10-digit number'), findsOneWidget);
  });
}
