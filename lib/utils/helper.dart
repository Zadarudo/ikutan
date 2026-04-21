import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helper {
  static void onTapOutside (PointerDownEvent event) {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static String formatDate(DateTime date) {
    return DateFormat('EEE, yyyy-MM-dd').format(date);
  }
}