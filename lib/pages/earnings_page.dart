import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class EarningsPage extends StatelessWidget {
  EarningsPage({super.key});

  final List<double> dailyEarnings = [350, 500, 450, 700, 600, 800, 650];
  final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  final List<Map<String, dynamic>> transactions = [
    {
      'client': 'Ruthwick',
      'location': 'Hyderabad',
      'work': 'Night Security Shift',
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'amount': 800
    },
    {
      'client': 'Sanjay',
      'location': 'Chennai',
      'work': 'Event Waiter',
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'amount': 650
    },
    {
      'client': 'Bhavya',
      'location': 'Bangalore',
      'work': 'Housekeeping',
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'amount': 600
    },
    {
      'client': 'Raina',
      'location': 'Pune',
      'work': 'Nanny Day Shift',
      'date': DateTime.now().subtract(const Duration(days: 4)),
      'amount': 500
    },
  ];

  List<FlSpot> getSpots() {
    return List.generate(
      dailyEarnings.length,
      (i) => FlSpot(i.toDouble(), dailyEarnings[i]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1EFEC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1EFEC),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF030303)),
        title: const Text(
          'Earnings Overview',
          style: TextStyle(color: Color(0xFF030303)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Daily Earnings Graph
            Container(
              height: 220,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFD4C9BE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 1000,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          int index = value.toInt();
                          return Text(
                            index >= 0 && index < days.length ? days[index] : '',
                            style: const TextStyle(color: Color(0xFF030303)),
                          );
                        },
                        interval: 1,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      color: const Color(0xFF123458),
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF123458).withOpacity(0.5),
                            const Color(0xFF123458).withOpacity(0.1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      spots: getSpots(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Transactions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF030303),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemCount: transactions.length,
                separatorBuilder: (_, __) => const Divider(color: Color(0xFF030303)),
                itemBuilder: (context, index) {
                  final tx = transactions[index];
                  return ListTile(
                    leading: const Icon(Icons.account_circle, size: 32, color: Color(0xFF030303)),
                    title: Text(
                      '${tx['client']} • ${tx['location']}',
                      style: const TextStyle(color: Color(0xFF030303)),
                    ),
                    subtitle: Text(
                      '${tx['work']}\n${DateFormat('dd MMM yyyy, hh:mm a').format(tx['date'])}',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    trailing: Text(
                      '₹${tx['amount']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF123458),
                      ),
                    ),
                    isThreeLine: true,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
