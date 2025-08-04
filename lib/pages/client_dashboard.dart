import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class ClientDashboardPage extends StatefulWidget {
  const ClientDashboardPage({super.key});

  @override
  State<ClientDashboardPage> createState() => _ClientDashboardPageState();
}

class _ClientDashboardPageState extends State<ClientDashboardPage> {
  DateTime _selectedDate = DateTime.now();

  final List<Map<String, dynamic>> mockBookings = [
    {
      'date': DateTime.now(),
      'time': '10:00 AM',
      'name': 'Ruthvika',
      'service': 'House Cleaning',
      'location': 'Banjara Hills'
    },
    {
      'date': DateTime.now().add(const Duration(days: 1)),
      'time': '2:00 PM',
      'name': 'Adwaith',
      'service': 'Gardening',
      'location': 'Jubilee Hills'
    },
    {
      'date': DateTime.now().add(const Duration(days: 3)),
      'time': '6:30 PM',
      'name': 'Tejasree',
      'service': 'Babysitting',
      'location': 'Madhapur'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Title
              const Text(
                'Client Dashboard',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Dashboard Summary Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: constraints.maxWidth > 400 ? 1.3 : 1.1,
                    children: [
                      _buildDashboardBlock(
                        context,
                        icon: Icons.schedule,
                        title: "Upcoming Bookings",
                        subtitle: "2 scheduled",
                        onTap: () {},
                      ),
                      _buildDashboardBlock(
                        context,
                        icon: Icons.history,
                        title: "Recent Activities",
                        subtitle: "3 completed",
                        onTap: () {},
                      ),
                      _buildDashboardBlock(
                        context,
                        icon: Icons.account_balance_wallet,
                        title: "Payment Summary",
                        subtitle: "₹4,850 this month",
                        onTap: () {},
                      ),
                      _buildDashboardBlock(
                        context,
                        icon: Icons.favorite_border,
                        title: "Favorites",
                        subtitle: "5 professionals",
                        onTap: () {},
                      ),
                      _buildDashboardBlock(
                        context,
                        icon: Icons.work_outline,
                        title: "In Progress",
                        subtitle: "1 active request",
                        onTap: () {},
                      ),
                      _buildDashboardBlock(
                        context,
                        icon: Icons.notifications_active,
                        title: "Reminders",
                        subtitle: "1 payment due",
                        hasDot: true,
                        onTap: () {},
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 32),

              // Calendar below dashboard
              Text(
                'Select Date',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 100,
                child: DatePicker(
                  DateTime.now(),
                  initialSelectedDate: _selectedDate,
                  selectionColor: const Color(0xFF123458),
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

              // Upcoming bookings filtered by selected date
              Text(
                'Bookings on ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 12),
              ..._getBookingsForSelectedDate(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getBookingsForSelectedDate() {
    final filtered = mockBookings
        .where((booking) =>
            booking['date'].day == _selectedDate.day &&
            booking['date'].month == _selectedDate.month &&
            booking['date'].year == _selectedDate.year)
        .toList();

    if (filtered.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'No bookings on this day.',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        )
      ];
    }

    return filtered
        .map(
          (booking) => Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
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
            child: Row(
              children: [
                const Icon(Icons.person_outline, color: Color(0xFF123458)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${booking['service']} • ${booking['location']}',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Text(
                        booking['time'],
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  Widget _buildDashboardBlock(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool hasDot = false,
  }) {
    return GestureDetector(
      onTap: onTap,
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
                Icon(icon, color: const Color(0xFF123458), size: 18),
                if (hasDot)
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
      ),
    );
  }
}
