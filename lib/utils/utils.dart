import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
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
    throw Exception('Failed to upload file: ${response.reasonPhrase}');
  }
}
