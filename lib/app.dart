
import 'package:flutter/material.dart';
import 'splash_page.dart';

class ArchonApp extends StatelessWidget {
  const ArchonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ARCHON',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
    );
  }
}
