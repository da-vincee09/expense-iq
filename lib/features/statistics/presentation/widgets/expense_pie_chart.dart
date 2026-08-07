import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// Displays an expense distribution chart.
///
/// Visualizes spending across different categories
/// using a pie chart to show expense proportions.
class ExpensePieChart extends StatelessWidget {
  final Map<String, double> expenses;

  const ExpensePieChart({
    super.key,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const Center(
        child: Text('No expense data'),
      );
    }

    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.amber,
    ];

    int colorIndex = 0;

    return SizedBox(
      height: 250,
      child: PieChart(
        PieChartData(
          sections: expenses.entries.map((entry) {
            final section = PieChartSectionData(
              value: entry.value,
              title: entry.key,
              radius: 70,
              color: colors[colorIndex % colors.length],
              titleStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            );

            colorIndex++;

            return section;
          }).toList(),
        ),
      ),
    );
  }
}