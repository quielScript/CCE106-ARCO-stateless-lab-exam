import 'package:flutter/material.dart';
import 'package:stateless_lab_exam/shopping_cart_page.dart';

void main() {
  runApp(const CampusStoreApp());
}

class CampusStoreApp extends StatelessWidget {
  const CampusStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFF2470C);

    return MaterialApp(
      title: 'Campus Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFFBFBFB),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF18181B),
          elevation: 0,
        ),
      ),
      home: const ShoppingCartPage(),
    );
  }
}
