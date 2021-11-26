import 'package:flutter/material.dart';
import 'pages/listing_page.dart';

void main() {
  runApp(const MyBookWishlist());
}

class MyBookWishlist extends StatelessWidget {
  const MyBookWishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: ListingPage(),
    );
  }
}


