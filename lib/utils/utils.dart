import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

String timeAgoFromIso(String isoString) {
  DateTime pastTime = DateTime.parse(isoString);

  Duration difference = DateTime.now().difference(pastTime);

  int seconds = difference.inSeconds;
  int minutes = difference.inMinutes;
  int hours = difference.inHours;
  int days = difference.inDays;
  int months = difference.inDays ~/ 30;
  int years = difference.inDays ~/ 365;

  if (seconds < 60) {
    return '$seconds detik yang lalu';
  } else if (minutes < 60) {
    return '$minutes menit yang lalu';
  } else if (hours < 24) {
    return '$hours jam yang lalu';
  } else if (days < 30) {
    return '$days hari yang lalu';
  } else if (months < 12) {
    return '$months bulan yang lalu';
  } else {
    return '$years tahun yang lalu';
  }
}

class SaveData {
  static const _mapKey = 'user_data';

  static Future<void> saveAuth(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = jsonEncode(data);
    await prefs.setString(_mapKey, jsonData);
  }

  static Future<Map<String, dynamic>> getAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(_mapKey);
    if (jsonData != null) {
      return jsonDecode(jsonData) as Map<String, dynamic>;
    }

    throw Exception("Error: No authentication found.");
  }

  static Future<void> clearAuth() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_mapKey);
  }
}
