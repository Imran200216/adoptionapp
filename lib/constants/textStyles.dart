import 'package:flutter/material.dart';

class CustomTextStyles {
  static const TextStyle headline = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: Colors.blue,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16.0,
    color: Colors.grey,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14.0,
    color: Colors.redAccent,
    fontStyle: FontStyle.italic,
  );
}
