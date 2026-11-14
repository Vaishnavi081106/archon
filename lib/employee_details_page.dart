
import 'package:flutter/material.dart';
import 'pages/dashboard_page.dart';

class EmployeeDetailsPage extends StatefulWidget {
  const EmployeeDetailsPage({super.key});

  @override
  State<EmployeeDetailsPage> createState() =>
      _EmployeeDetailsPageState();
}

class _EmployeeDetailsPageState
    extends State<EmployeeDetailsPage> {
  final nameController = TextEditingController();
  final companyController = TextEditingController();
  final roleController = TextEditingController();
  final experienceController = TextEditingController();
  final ageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    companyController.dispose();
    roleController.dispose();
    experienceController.dispose();
    ageController.dispose();
    super.dispose();
  }

  Widget buildField(
      String label,
      TextEditingController controller, {
        TextInputType keyboardType = TextInputType.text,
        IconData? icon,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text('ARCHON'),
        backgroundColor: const Color(0xFF1769AA),
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // COMPANY LOGO
            Center(
              child: Image.asset(
                'assets/archon_logo.jpg',
                width: 140,
                height: 140,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 12),

            // HEADING BELOW LOGO
            const Center(
              child: Text(
                'Employee Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1769AA),
                ),
              ),
            ),

            const SizedBox(height: 8),

            const Center(
              child: Text(
                'Enter your details to continue',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),

            const SizedBox(height: 30),

            buildField(
              'Employee Name',
              nameController,
              icon: Icons.person,
            ),

            buildField(
              'Company Name',
              companyController,
              icon: Icons.business,
            ),

            buildField(
              'Role / Designation',
              roleController,
              icon: Icons.work,
            ),

            buildField(
              'Experience (Years)',
              experienceController,
              keyboardType: TextInputType.number,
              icon: Icons.timeline,
            ),

            buildField(
              'Age',
              ageController,
              keyboardType: TextInputType.number,
              icon: Icons.cake,
            ),

            const SizedBox(height: 15),

            // CONTINUE BUTTON
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1769AA),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                onPressed: () {
                  final name = nameController.text.trim();
                  final company = companyController.text.trim();
                  final role = roleController.text.trim();
                  final experience =
                  experienceController.text.trim();
                  final age = ageController.text.trim();

                  if (name.isEmpty ||
                      company.isEmpty ||
                      role.isEmpty ||
                      experience.isEmpty ||
                      age.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill all details'),
                      ),
                    );
                    return;
                  }

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardPage(
                        employeeName: name,
                        companyName: company,
                        role: role,
                        experience: experience,
                        age: age,
                      ),
                    ),
                  );
                },

                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
