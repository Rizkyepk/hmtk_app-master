import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Secrets {
  static String apiKey = dotenv.env['MYHMTK_API_KEY']!;
  static String cdnApiKey = dotenv.env['CDN_KEY']!;
}

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

String formatNumber(int number) {
  NumberFormat formatter = NumberFormat('#,##0', 'id_ID');
  return formatter.format(number);
}

String formatDateTime(String isoDateTime) {
  DateTime dateTime = DateTime.parse(isoDateTime);
  DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
  return formatter.format(dateTime);
}

String formatDate(String isoDateTime) {
  DateTime date = DateTime.parse(isoDateTime);
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(date);
}

String formatTime(TimeOfDay time) {
  final formatter = DateFormat('HH:mm');
  final timeString = TimeOfDay(hour: time.hour, minute: time.minute);
  return formatter.format(DateTime(2020, 1, 1, timeString.hour, timeString.minute));
}

String getFirstString(String string) {
  return string.split(" ")[0];
}

String limitString(String string, int limit, {String? trail = '...'}) {
  if (string.length > limit) {
    String sub = string.substring(0, limit);
    if (trail != null) {
      return sub + trail;
    }
    return sub;
  }
  return string;
}

String getFirstLimit(String name, {int limit = 7}) {
  return getFirstString(limitString(name, limit));
}

String toTitleCase(String text) {
  if (text.isEmpty) {
    return text;
  }

  return text.toLowerCase().split(' ').map((word) {
    return word.isNotEmpty
        ? '${word[0].toUpperCase()}${word.substring(1)}'
        : '';
  }).join(' ');
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

Future<String> uploadFileToCDN(File file,
    {String contentType = "image/png", String? name}) async {
  var uri = Uri(
    scheme: 'https',
    host: 'cdn.jeyy.xyz',
    path: '/upload_file_myhmtk',
    queryParameters: {'content_type': contentType, 'name': name},
  );

  var request = MultipartRequest('POST', uri);
  request.headers['auth'] = Secrets.cdnApiKey;

  // Add the file
  var fileStream = ByteStream(file.openRead());
  var length = await file.length();
  var multipartFile = MultipartFile('file', fileStream, length,
      filename: file.path.split('/').last);
  request.files.add(multipartFile);

  // Send the request
  var response = await request.send();

  // Check the response
  if (response.statusCode == 200) {
    var responseBody = await response.stream.bytesToString();
    var parsedResponse = Map<String, dynamic>.from(jsonDecode(responseBody));
    var url = parsedResponse['url'];
    return url;
  } else {
    throw Exception('Failed to upload file: ${response.statusCode}');
  }
}

enum FutureStatus {
  loading,
  success,
  error,
}

class FutureResult<T> {
  FutureStatus? status;
  T? data;
  String? errorMessage;

  FutureResult.loading()
      : status = FutureStatus.loading,
        data = null,
        errorMessage = null;
  FutureResult.success(this.data)
      : status = FutureStatus.success,
        errorMessage = null;
  FutureResult.error(this.errorMessage)
      : status = FutureStatus.error,
        data = null;
}
