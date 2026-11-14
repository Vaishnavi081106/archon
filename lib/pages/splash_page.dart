import 'package:flutter/material.dart';
import 'employee_details_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const EmployeeDetailsPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/archon_logo.jpg', width: 140),
            const SizedBox(height: 12),
            const Text('ARCHON',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const Text('Construction Site Monitoring'),
          ],
        ),
      ),
    );
  }
}
