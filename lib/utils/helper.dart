import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helper {
  static void onTapOutside(PointerDownEvent event) {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '-';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('EEE, yyyy-MM-dd').format(date);
    } catch (_) {
      return dateStr;
    }
  }
}