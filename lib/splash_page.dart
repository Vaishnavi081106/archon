
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

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
          const EmployeeDetailsPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(
              'assets/archon_logo.jpg',
              width: 160,
              height: 160,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 20),

            const Text(
              'ARCHON',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1769AA),
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Construction Site Monitoring',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            const CircularProgressIndicator(
              color: Color(0xFF1769AA),
            ),
          ],
        ),
      ),
    );
  }
}
