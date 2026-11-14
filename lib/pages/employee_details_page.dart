import 'package:flutter/material.dart';
import '../widgets/text_input.dart';
import 'dashboard_page.dart';

class EmployeeDetailsPage extends StatefulWidget {
  const EmployeeDetailsPage({super.key});

  @override
  State<EmployeeDetailsPage> createState() => _EmployeeDetailsPageState();
}

class _EmployeeDetailsPageState extends State<EmployeeDetailsPage> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final company = TextEditingController();
  final role = TextEditingController();
  final experience = TextEditingController();
  final age = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    company.dispose();
    role.dispose();
    experience.dispose();
    age.dispose();
    super.dispose();
  }

  void continueToHome() {
    if (!formKey.currentState!.validate()) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => DashboardPage(
          employeeName: name.text,
          companyName: company.text,
          role: role.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employee Details')),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextInput(label: 'Employee Name', controller: name),
            TextInput(label: 'Company Name', controller: company),
            TextInput(label: 'Employee Role', controller: role),
            TextInput(
              label: 'Experience (Years)',
              controller: experience,
              keyboardType: TextInputType.number,
            ),
            TextInput(
              label: 'Age',
              controller: age,
              keyboardType: TextInputType.number,
            ),
            FilledButton(
              onPressed: continueToHome,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
