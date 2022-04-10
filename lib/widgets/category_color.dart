import 'package:flutter/material.dart';

Color getCategoryColor(String category) {
  switch (category) {
    case 'Entertainment':
      return Colors.red;
    case 'Personal':
      return Colors.blue;
    case 'Food':
      return Colors.green;
    case 'Transportation':
      return Colors.purple;
    case 'Any':
      return Colors.orange;
    case 'Business':
      return Colors.black;
  }
  return Colors.white;
}
