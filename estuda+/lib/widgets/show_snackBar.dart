import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(error),
      duration: const Duration(seconds: 3),
    ),
  );
}
