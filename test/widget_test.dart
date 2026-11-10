import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stateless_lab_exam/main.dart';
import 'package:stateless_lab_exam/shopping_cart_page.dart';

void main() {
  testWidgets('ShoppingCartPage renders all elements and handles callbacks',
      (WidgetTester tester) async {
    final List<String> logs = <String>[];
    final originalDebugPrint = debugPrint;
    debugPrint = (String? message, {int? wrapWidth}) {
      if (message != null) logs.add(message);
    };

    try {
      // Set test surface size to realistic mobile dimensions (e.g., 400x900)
      tester.view.physicalSize = const Size(400, 950);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      // Build our app and trigger a frame.
      await tester.pumpWidget(const CampusStoreApp());
      await tester.pumpAndSettle();

      // 1. Verify AppBar components
      expect(find.text('My Cart'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
      expect(find.text('3'), findsAtLeastNWidgets(1));

      // 2. Verify Introduction Section
      expect(find.text('CAMPUS STORE'), findsOneWidget);
      expect(find.text('Ready for checkout'), findsOneWidget);
      expect(
        find.text('Review your items before placing your order.'),
        findsOneWidget,
      );

      // 3. Verify Delivery Information Card
      expect(find.text('Deliver to Glenn Oliva'), findsOneWidget);
      expect(find.text('Matina, Davao City'), findsOneWidget);
      expect(find.text('Change'), findsOneWidget);

      // 4. Verify Order Items header
      expect(find.text('Order Items'), findsOneWidget);
      expect(find.text('3 items'), findsOneWidget);

      // 5. Verify the 3 product cards
      expect(find.byType(CartItemCard), findsNWidgets(3));
      expect(find.text('Wireless Mouse'), findsOneWidget);
      expect(find.text('PHP 450.00'), findsOneWidget);
      expect(find.text('USB-C Hub'), findsOneWidget);
      expect(find.text('PHP 850.00'), findsOneWidget);
      expect(find.text('Laptop Stand'), findsOneWidget);
      expect(find.text('PHP 700.00'), findsOneWidget);

      // 6. Verify Discount Banner
      expect(find.text('STUDENT10 applied'), findsOneWidget);
      expect(find.text('10% discount on items'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);

      // 7. Verify Payment Summary
      expect(find.text('Payment Summary'), findsOneWidget);
      expect(find.text('Subtotal'), findsOneWidget);
      expect(find.text('PHP 2,000.00'), findsOneWidget);
      expect(find.text('Discount (10%)'), findsOneWidget);
      expect(find.text('- PHP 200.00'), findsOneWidget);
      expect(find.text('Delivery Fee'), findsOneWidget);
      expect(find.text('PHP 50.00'), findsOneWidget);
      expect(find.text('Total'), findsOneWidget);
      expect(find.text('PHP 1,850.00'), findsOneWidget);

      // 8. Verify Place Order Button
      expect(find.text('Place Order'), findsOneWidget);
      expect(find.byIcon(Icons.lock_rounded), findsOneWidget);

      // Test all required button callbacks and console output
      // a. Back arrow
      await tester.tap(find.byIcon(Icons.arrow_back));
      expect(logs.contains('Back clicked'), isTrue);

      // b. Shopping bag
      await tester.tap(find.byIcon(Icons.shopping_bag_outlined));
      expect(logs.contains('Cart clicked'), isTrue);

      // c. Change delivery address
      await tester.tap(find.text('Change'));
      expect(logs.contains('Change delivery address clicked'), isTrue);

      // d. Increase quantity on first item (Wireless Mouse)
      await tester.tap(find.byIcon(Icons.add).first);
      expect(logs.contains('Increase quantity: Wireless Mouse'), isTrue);

      // e. Decrease quantity on first item (Wireless Mouse)
      await tester.tap(find.byIcon(Icons.remove).first);
      expect(logs.contains('Decrease quantity: Wireless Mouse'), isTrue);

      // f. Delete button on first item (Wireless Mouse)
      await tester.tap(find.byIcon(Icons.delete_outline_rounded).first);
      expect(logs.contains('Remove item: Wireless Mouse'), isTrue);

      // g. Place Order button (ensure visible before tap)
      await tester.ensureVisible(find.text('Place Order'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Place Order'));
      expect(
        logs.contains('Place order clicked! Total: PHP 1850.00'),
        isTrue,
      );
    } finally {
      debugPrint = originalDebugPrint;
    }
  });
}
