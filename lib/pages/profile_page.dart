import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String company;
  final String role;

  const ProfilePage({
    super.key,
    required this.name,
    required this.company,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
          const SizedBox(height: 12),
          Text(name, style: const TextStyle(fontSize: 20)),
          Text(company),
          Text(role),
        ],
      ),
    );
  }
}
