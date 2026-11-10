import 'package:flutter/material.dart';

/// Campus Store: Shopping Cart Page
/// Implemented as a StatelessWidget following modern Flutter standards
/// with the warm orangish light mode palette (OKLCH primary: oklch(0.6404 0.2153 35.9003)).
class ShoppingCartPage extends StatelessWidget {
  final String studentName;
  final String studentAddress;

  const ShoppingCartPage({
    super.key,
    this.studentName = 'Glenn Oliva',
    this.studentAddress = 'Matina, Davao City',
  });

  // Palette derived from the provided OKLCH color token definition:
  // --primary: oklch(0.6404 0.2153 35.9003) -> #F2470C
  // --accent: oklch(0.9656 0.0176 39.4009) -> #FFF0EB
  // --accent-foreground: oklch(0.5581 0.1911 35.3377) -> #CB3706
  // --border: oklch(0.9300 0.0094 286.2156) -> #E5E7EB
  static const Color primaryColor = Color(0xFFF2470C);
  static const Color accentBg = Color(0xFFFFF0EB);
  static const Color accentBorder = Color(0xFFFFD5C7);
  static const Color accentForeground = Color(0xFFCB3706);
  static const Color backgroundLight = Color(0xFFFBFBFB);
  static const Color textDark = Color(0xFF18181B);
  static const Color textMuted = Color(0xFF71717A);
  static const Color cardBorder = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textDark),
          tooltip: 'Back',
          onPressed: () {
            debugPrint('Back clicked');
          },
        ),
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: textDark,
            fontWeight: FontWeight.w800,
            fontSize: 20,
            letterSpacing: -0.3,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    color: textDark,
                    size: 26,
                  ),
                  tooltip: 'Shopping Cart',
                  onPressed: () {
                    debugPrint('Cart clicked');
                  },
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: const Center(
                      child: Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Introduction Section
              _buildIntroductionSection(),
              const SizedBox(height: 16),

              // 2. Delivery Information Card
              _buildDeliveryCard(studentName, studentAddress),
              const SizedBox(height: 20),

              // 3. Order Items Heading
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(
                    child: Text(
                      'Order Items',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: textDark,
                      ),
                    ),
                  ),
                  Text(
                    '3 items',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: textMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // 4. Product Cards
              const CartItemCard(
                productName: 'Wireless Mouse',
                price: 'PHP 450.00',
                quantity: 1,
                icon: Icons.mouse,
              ),
              const SizedBox(height: 12),
              const CartItemCard(
                productName: 'USB-C Hub',
                price: 'PHP 850.00',
                quantity: 1,
                icon: Icons.hub_outlined,
              ),
              const SizedBox(height: 12),
              const CartItemCard(
                productName: 'Laptop Stand',
                price: 'PHP 700.00',
                quantity: 1,
                icon: Icons.laptop_mac_outlined,
              ),
              const SizedBox(height: 16),

              // 5. Discount Banner
              _buildDiscountBanner(),
              const SizedBox(height: 16),

              // 6. Payment Summary Card
              _buildPaymentSummaryCard(),
              const SizedBox(height: 18),

              // 7. Place Order Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {
                    debugPrint('Place order clicked! Total: PHP 1850.00');
                  },
                  icon: const Icon(
                    Icons.lock_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Place Order',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.2,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  /// Introduction Section: badge, heading, and subtitle
  Widget _buildIntroductionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: accentBg,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: accentBorder),
          ),
          child: const Text(
            'CAMPUS STORE',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: 0.6,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Ready for checkout',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: textDark,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Review your items before placing your order.',
          style: TextStyle(
            fontSize: 13,
            color: textMuted,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  /// Delivery Information Card
  Widget _buildDeliveryCard(String name, String address) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: primaryColor, size: 24),
          Container(
            height: 28,
            width: 1,
            color: cardBorder,
            margin: const EdgeInsets.symmetric(horizontal: 12),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Deliver to $name',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  address,
                  style: const TextStyle(
                    fontSize: 12,
                    color: textMuted,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              debugPrint('Change delivery address clicked');
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Change',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Discount Banner
  Widget _buildDiscountBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: accentBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentBorder),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.sell_outlined,
            color: primaryColor,
            size: 22,
          ),
          Container(
            height: 26,
            width: 1,
            color: accentBorder,
            margin: const EdgeInsets.symmetric(horizontal: 12),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'STUDENT10 applied',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: textDark,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '10% discount on items',
                  style: TextStyle(
                    fontSize: 11,
                    color: textMuted,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.check_circle,
            color: primaryColor,
            size: 22,
          ),
        ],
      ),
    );
  }

  /// Payment Summary Card
  Widget _buildPaymentSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Summary',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: textDark,
            ),
          ),
          const SizedBox(height: 12),
          _buildSummaryRow('Subtotal', 'PHP 2,000.00'),
          const SizedBox(height: 8),
          _buildSummaryRow('Discount (10%)', '- PHP 200.00'),
          const SizedBox(height: 8),
          _buildSummaryRow('Delivery Fee', 'PHP 50.00'),
          const SizedBox(height: 12),
          const Divider(color: cardBorder, thickness: 1, height: 1),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(
                child: Text(
                  'Total',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: textDark,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(
                'PHP 1,850.00',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 17,
                  color: textDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            color: textDark,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

/// Reusable Cart Item Card
/// Accepts product name, price, quantity, and icon via constructor parameters.
class CartItemCard extends StatelessWidget {
  final String productName;
  final String price;
  final int quantity;
  final IconData icon;

  const CartItemCard({
    super.key,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = ShoppingCartPage.primaryColor;
    const Color accentBg = ShoppingCartPage.accentBg;
    const Color accentBorder = ShoppingCartPage.accentBorder;
    const Color textDark = ShoppingCartPage.textDark;
    const Color textMuted = ShoppingCartPage.textMuted;
    const Color cardBorder = ShoppingCartPage.cardBorder;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Warm orangish rounded container with relevant Material icon
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: accentBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: accentBorder),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 30,
            ),
          ),
          const SizedBox(width: 14),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  price,
                  style: const TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),

                // Quantity selector: Minus button, quantity display, Plus button
                Row(
                  children: [
                    _buildQtyButton(
                      icon: Icons.remove,
                      onPressed: () {
                        debugPrint('Decrease quantity: $productName');
                      },
                    ),
                    Container(
                      width: 36,
                      height: 28,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: cardBorder),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$quantity',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: textDark,
                        ),
                      ),
                    ),
                    _buildQtyButton(
                      icon: Icons.add,
                      onPressed: () {
                        debugPrint('Increase quantity: $productName');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Delete IconButton
          IconButton(
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: textMuted,
              size: 22,
            ),
            tooltip: 'Remove Item',
            onPressed: () {
              debugPrint('Remove item: $productName');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQtyButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: ShoppingCartPage.primaryColor),
        ),
        child: Center(
          child: Icon(
            icon,
            size: 16,
            color: ShoppingCartPage.primaryColor,
          ),
        ),
      ),
    );
  }
}
