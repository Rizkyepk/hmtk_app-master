import 'package:flutter/material.dart';
import 'package:hmtk_app/utils/utils.dart';

Widget snap(Function(Map<String, dynamic> user) buildAccountWidget) {
  return FutureBuilder<Map<String, dynamic>>(
    future: SaveData.getAuth(),
    builder:
        (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        final user = snapshot.data!["user"];
        return buildAccountWidget(user);
      }
    },
  );
}
