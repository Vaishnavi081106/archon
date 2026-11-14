
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsPage extends StatefulWidget {
  final List<String> uploadedSections;

  const AnalyticsPage({
    super.key,
    required this.uploadedSections,
  });

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  final List<String> days = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  // Daily work completion percentage
  final List<double> completion = [
    40,
    60,
    75,
    55,
    90,
    100,
  ];

  final List<String> allSections = [
    'Raw Material Photos',
    'Site Before Work',
    'Site After Work',
    'Foundation Work Photos',
    'Building Work Photos',
    'Daily Site Progress Photos',
    'Equipment Photos',
    'Completed Work Photos',
  ];

  void updateWork(int index) {
    final controller = TextEditingController(
      text: completion[index].toInt().toString(),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${days[index]} Work Completion'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Completion Percentage',
              suffixText: '%',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final value = double.tryParse(controller.text);

                if (value != null && value >= 0 && value <= 100) {
                  setState(() {
                    completion[index] = value;
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final uploadedCount = allSections
        .where((section) => widget.uploadedSections.contains(section))
        .length;

    final pendingCount = allSections.length - uploadedCount;

    final average = completion.reduce((a, b) => a + b) /
        completion.length;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Analytical Dashboard',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        // Work Completion Summary
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Average Work Completion',
                  style: TextStyle(fontSize: 17),
                ),
                const SizedBox(height: 12),
                Text(
                  '${average.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: average / 100,
                  minHeight: 10,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 22),

        // Daily Bar Chart
        const Text(
          'Work Completed in Time',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 5),

        const Text(
          'Daily work completion percentage',
          style: TextStyle(color: Colors.grey),
        ),

        const SizedBox(height: 15),

        Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 20, 16, 12),
            child: SizedBox(
              height: 260,
              child: BarChart(
                BarChartData(
                  minY: 0,
                  maxY: 100,
                  barGroups: List.generate(
                    days.length,
                        (index) {
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: completion[index],
                            color: Colors.green,
                            width: 24,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ],
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 38,
                        interval: 20,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}%',
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();

                          if (index < 0 || index >= days.length) {
                            return const SizedBox();
                          }

                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              days[index],
                              style: const TextStyle(fontSize: 11),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  gridData: const FlGridData(
                    show: true,
                    horizontalInterval: 20,
                  ),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 15),

        const Text(
          'Update Daily Work',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        ...List.generate(days.length, (index) {
          return Card(
            child: ListTile(
              title: Text(days[index]),
              subtitle: Text(
                'Completed: ${completion[index].toInt()}%',
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
                onPressed: () => updateWork(index),
              ),
            ),
          );
        }),

        const SizedBox(height: 20),

        // Photo Upload Summary
        const Text(
          'Site Photo Status',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Card(
          child: ListTile(
            title: const Text('Uploaded Photos'),
            trailing: Text(
              '$uploadedCount / 8',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        Card(
          child: ListTile(
            title: const Text('Pending Photos'),
            trailing: Text(
              '$pendingCount / 8',
              style: const TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        ...allSections.map((section) {
          final uploaded = widget.uploadedSections.contains(section);

          return Card(
            child: ListTile(
              leading: Icon(
                uploaded ? Icons.check_circle : Icons.pending,
                color: uploaded ? Colors.green : Colors.grey,
              ),
              title: Text(section),
              trailing: Text(
                uploaded ? 'Uploaded' : 'Pending',
              ),
            ),
          );
        }),
      ],
    );
  }
}
