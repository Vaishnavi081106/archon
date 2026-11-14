
import 'package:flutter/material.dart';

import '../widgets/activity_post.dart';
import 'analytics_page.dart';
import 'project_page.dart';
import 'profile_page.dart';

class DashboardPage extends StatefulWidget {
  final String employeeName;
  final String companyName;
  final String role;
  final String experience;
  final String age;

  const DashboardPage({
    super.key,
    required this.employeeName,
    required this.companyName,
    required this.role,
    required this.experience,
    required this.age,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int pageIndex = 0;

  final Map<String, bool> photoAnalysis = {};

  final List<String> activities = [
    'Raw Material Photos',
    'Site Before Work',
    'Site After Work',
    'Foundation Work Photos',
    'Building Work Photos',
    'Daily Site Progress Photos',
    'Equipment Photos',
    'Completed Work Photos',
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      homeFeed(),
      const ProjectPage(),
      AnalyticsPage(
        uploadedSections: photoAnalysis.keys.toList(),
      ),
      ProfilePage(
        name: widget.employeeName,
        company: widget.companyName,
        role: widget.role,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ARCHON',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1769AA),
        foregroundColor: Colors.white,
      ),
      body: pages[pageIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: pageIndex,
        onDestinationSelected: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_outlined),
            label: 'Projects',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart),
            label: 'Analytics',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget homeFeed() {
    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        Text(
          'Welcome, ${widget.employeeName}',
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text('${widget.companyName} • ${widget.role}'),
        Text('Experience: ${widget.experience} years'),
        Text('Age: ${widget.age}'),

        const SizedBox(height: 20),

        const Text(
          'Daily Site Updates',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        ...activities.map(
              (title) => ActivityPost(
            title: title,
            employeeName: widget.employeeName,
            onPhotoChanged: (uploaded) {
              setState(() {
                if (uploaded) {
                  photoAnalysis[title] = true;
                } else {
                  photoAnalysis.remove(title);
                }
              });
            },
          ),
        ),

        const SizedBox(height: 15),

        const Text(
          'Daily Work Timing',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),

        ActivityPost(
          title: 'Daily Work Start Time',
          employeeName: widget.employeeName,
          isTime: true,
        ),

        ActivityPost(
          title: 'Daily Work End Time',
          employeeName: widget.employeeName,
          isTime: true,
        ),
      ],
    );
  }
}
