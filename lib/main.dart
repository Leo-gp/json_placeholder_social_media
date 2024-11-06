import 'package:flutter/material.dart';
import 'package:json_placeholder_social_media/injection_container.dart';
import 'package:json_placeholder_social_media/presentation/pages/users_page.dart';

void main() {
  setupLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UsersPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
