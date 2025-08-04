import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import '../pages/job_requests_page.dart';
import '../pages/earnings_page.dart';
import '../widgets/updates_carousel.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class ProfessionalDashboardPage extends StatefulWidget {
  const ProfessionalDashboardPage({super.key});

  @override
  State<ProfessionalDashboardPage> createState() => _ProfessionalDashboardPageState();
}

class _ProfessionalDashboardPageState extends State<ProfessionalDashboardPage> {
  bool isAvailable = true;
  bool hasNewRequests = true;
  DateTime _selectedDate = DateTime(2025, 4, 8);

  final Map<String, List<Map<String, dynamic>>> jobTimelinePerDate = {};

  final List<String> mockTitles = [
    'Residential Cleaning',
    'Cafe Support',
    'Daycare Babysitting',
    'Event Setup',
    'Nursing Assistance',
    'Kitchen Help',
    'Landscaping',
    'Pet Grooming',
    'Delivery Drop',
    'Reception Duty',
  ];

  final List<String> mockDescriptions = [
    'Morning shift duties and upkeep.',
    'Assist in cleaning and organizing.',
    'Childcare and play activities.',
    'Set up and teardown support.',
    'Patient care and hygiene.',
    'Dishwashing and maintenance.',
    'Plant watering and trimming.',
    'Pet washing and brushing.',
    'Deliver parcels in the area.',
    'Greet and guide customers.',
  ];

  final List<Color> mockColors = [
    Colors.orange.shade100,
    Colors.green.shade100,
    Colors.pink.shade100,
    Colors.teal.shade100,
    Colors.blue.shade100,
    Colors.brown.shade100,
    Colors.purple.shade100,
    Colors.red.shade100,
    Colors.indigo.shade100,
    Colors.cyan.shade100,
  ];

  final List<String> mockTimes = [
    '08:00 AM',
    '09:30 AM',
    '11:00 AM',
    '01:00 PM',
    '02:30 PM',
    '04:00 PM',
    '06:00 PM',
  ];

  final List<String> hyderabadLocations = [
    'Banjara Hills',
    'Jubilee Hills',
    'Gachibowli',
    'Madhapur',
    'Kondapur',
    'Begumpet',
    'Hitech City',
    'Kukatpally',
    'Secunderabad',
    'Mehdipatnam',
    'Dilsukhnagar',
    'Attapur',
    'Himayatnagar',
    'Tolichowki',
    'Somajiguda',
  ];

  List<Map<String, dynamic>> get currentTimeline {
    String key = _selectedDate.toIso8601String().substring(0, 10);
    return jobTimelinePerDate[key] ?? [];
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return now.year == date.year && now.month == date.month && now.day == date.day;
  }

  @override
  void initState() {
    super.initState();
    _generateMockTimeline();
  }

  void _generateMockTimeline() {
    final startDate = DateTime(2025, 4, 8);
    final rand = Random();

    for (int i = 0; i < 10; i++) {
      final date = startDate.add(Duration(days: i));
      final key = DateFormat('yyyy-MM-dd').format(date);

      final jobCount = rand.nextBool() ? 1 : 2;
      final List<Map<String, dynamic>> jobs = [];

      for (int j = 0; j < jobCount; j++) {
        final index = rand.nextInt(mockTitles.length);
        final time = mockTimes[rand.nextInt(mockTimes.length)];
        final location = hyderabadLocations[rand.nextInt(hyderabadLocations.length)];

        jobs.add({
          'time': time,
          'title': mockTitles[index],
          'description': mockDescriptions[index],
          'location': location,
          'color': mockColors[index],
        });
      }

      jobTimelinePerDate[key] = jobs;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String todayLabel = DateFormat.yMMMMEEEEd().format(_selectedDate);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Professional Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.star, color: Colors.deepPurple),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Great job! You've received 5 new 5-star reviews this week. Keep delivering excellence!",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: constraints.maxWidth > 400 ? 1.3 : 1.1,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const JobRequestsPage()));
                        },
                        child: _infoCard(
                          icon: Icons.notifications_active_outlined,
                          title: 'Job Requests',
                          subtitle: '3 new today',
                          showDot: hasNewRequests,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EarningsPage()));
                        },
                        child: _infoCard(
                          icon: Icons.account_balance_wallet,
                          title: 'Earnings',
                          subtitle: '₹12,350',
                        ),
                      ),
                      _availabilityCard(),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              const Text("Latest Updates", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const UpdatesCarousel(
                updates: [
                  'Upcoming job at 4:00 PM today.',
                  'New booking request from Anjali.',
                  'Reminder: Weekly report due tomorrow.',
                ],
              ),
              const SizedBox(height: 32),
              Text(
                "${isToday(_selectedDate) ? "Today's Activity" : "Activity on"} — $todayLabel",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 100,
                child: DatePicker(
                  DateTime(2025, 4, 8),
                  initialSelectedDate: _selectedDate,
                  selectionColor: Colors.deepPurple,
                  selectedTextColor: Colors.white,
                  daysCount: 10,
                  onDateChange: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),
              _buildTimeline(),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Wallet Balance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(height: 4),
                        Text('₹5,250', style: TextStyle(fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Withdraw'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    bool showDot = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 18, color: Colors.deepPurple),
              if (showDot)
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _availabilityCard() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isAvailable = !isAvailable;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.calendar_today,
                  color: isAvailable ? Colors.green : Colors.red,
                  size: 18,
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: isAvailable,
                    onChanged: (value) {
                      setState(() {
                        isAvailable = value;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Availability',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isAvailable ? 'Available for work' : 'Not available',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeline() {
    final timeline = currentTimeline;

    if (timeline.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Text("No activity for this date."),
        ),
      );
    }

    return Column(
      children: timeline.map((event) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 60, child: Text(event['time'], style: const TextStyle(fontWeight: FontWeight.bold))),
              Column(
                children: [
                  Container(width: 12, height: 12, decoration: const BoxDecoration(color: Colors.deepPurple, shape: BoxShape.circle)),
                  Container(width: 2, height: 60, color: Colors.deepPurple.shade100),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: event['color'], borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(event['description']),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 14, color: Colors.deepPurple),
                          const SizedBox(width: 4),
                          Text(event['location'], style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
