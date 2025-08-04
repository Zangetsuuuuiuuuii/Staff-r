import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class MyJobsPage extends StatefulWidget {
  const MyJobsPage({super.key});

  @override
  State<MyJobsPage> createState() => _MyJobsPageState();
}

class _MyJobsPageState extends State<MyJobsPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, bool> _availability = {};
  final Set<String> selectedSlots = {};

  final List<Map<String, String>> bookings = [
    {"time": "3:00 PM", "location": "ECIL"},
  ];

  final List<String> timeSlots = List.generate(12, (i) {
    final time = TimeOfDay(hour: 9 + i, minute: 0);
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(dt);
  });

  void _promptAvailabilitySelection(DateTime day) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Set Availability"),
          content: const Text("Mark this date as available or unavailable?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _selectedDay = day;
                  _availability[day] = true;
                });
              },
              child: const Text("Available"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _selectedDay = day;
                  _availability[day] = false;
                });
              },
              child: const Text("Unavailable"),
            ),
          ],
        );
      },
    );
  }

  void _toggleSlot(String slot) {
    setState(() {
      if (selectedSlots.contains(slot)) {
        selectedSlots.remove(slot);
      } else {
        selectedSlots.add(slot);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isGreen = _selectedDay != null && (_availability[_selectedDay!] ?? false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Jobs"),
        backgroundColor: const Color(0xFF123458),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner map image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Image.asset(
                    'assets/Map.png',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const Positioned(
                  bottom: 10,
                  left: 16,
                  child: Chip(
                    label: Text("Next Upcoming Task"),
                    backgroundColor: Colors.white,
                  ),
                )
              ],
            ),

            // Upcoming jobs list
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: bookings.map((job) {
                  return ListTile(
                    leading: const Icon(Icons.work, color: Colors.teal),
                    title: Text("Job at ${job['location']}"),
                    subtitle: Text("Time: ${job['time']}"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  );
                }).toList(),
              ),
            ),

            // Calendar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TableCalendar(
                focusedDay: _focusedDay,
                firstDay: DateTime.utc(2020),
                lastDay: DateTime.utc(2030),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  _focusedDay = focusedDay;
                  _promptAvailabilitySelection(selectedDay);
                },
                calendarFormat: CalendarFormat.month,
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Month',
                },
                calendarStyle: CalendarStyle(
                  selectedDecoration: const BoxDecoration(color: Colors.teal, shape: BoxShape.circle),
                  todayDecoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                  defaultTextStyle: const TextStyle(color: Colors.black),
                  weekendTextStyle: const TextStyle(color: Colors.black),
                  outsideDaysVisible: false,
                ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    final isBlocked = _availability[day] == false;
                    final isAvailable = _availability[day] == true;

                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isBlocked
                            ? Colors.red
                            : isAvailable
                                ? Colors.green
                                : null,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Time slots
            if (isGreen)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Select Your Available Time Slots", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: timeSlots.map((slot) {
                        final isSelected = selectedSlots.contains(slot);
                        return ChoiceChip(
                          label: Text(slot),
                          selected: isSelected,
                          selectedColor: Colors.teal,
                          onSelected: (_) => _toggleSlot(slot),
                          labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
