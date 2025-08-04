import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/professional.dart';
import 'professional_reviews_page.dart';

class ProfessionalBookingPage extends StatefulWidget {
  final Professional professional;

  const ProfessionalBookingPage({super.key, required this.professional});

  @override
  State<ProfessionalBookingPage> createState() => _ProfessionalBookingPageState();
}

class _ProfessionalBookingPageState extends State<ProfessionalBookingPage> {
  DateTime selectedDate = DateTime.now();
  String? selectedTime;

  final List<String> timeSlots = [
    '09:00 AM', '10:00 AM', '11:00 AM',
    '01:00 PM', '02:00 PM', '03:00 PM', '04:00 PM',
  ];

  final List<String> unavailableSlots = ['10:00 AM', '02:00 PM'];

  @override
  Widget build(BuildContext context) {
    final pro = widget.professional;

    return Scaffold(
      appBar: AppBar(
        title: Text("Book ${pro.name}", style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF123458),
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Row(
            children: [
              Icon(Icons.arrow_back, size: 20),
              SizedBox(width: 4),
              Text("Back", style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Row(
              children: const [
                Icon(Icons.person, size: 20),
                SizedBox(width: 4),
                Text("Profile", style: TextStyle(fontSize: 12)),
              ],
            ),
          )
        ],
      ),
      backgroundColor: const Color(0xFFF1EFEC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(pro.imageUrl),
              radius: 50,
            ),
            const SizedBox(height: 12),
            Text(pro.name, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(pro.jobTitle, style: GoogleFonts.poppins(color: Colors.grey[700])),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(pro.rating.toString(), style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 8),
            Text("Charges: ₹${pro.hourlyRate.toStringAsFixed(0)}/hour",
                style: GoogleFonts.poppins(color: const Color(0xFF123458), fontSize: 14)),
            const SizedBox(height: 20),

            // Info Chips
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfessionalAboutPage(professional: pro),
                      ),
                    );
                  },
                  child: _infoChipWithLabel("6 years", "Experience", Icons.workspace_premium),
                ),
                _infoChipWithLabel("2.5K", "Clients", Icons.people),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfessionalReviewsPage(professionalId: pro.id.toString()),
                      ),
                    );
                  },
                  child: _infoChipWithLabel("1.1K", "Reviews", Icons.reviews),
                ),
              ],
            ),

            const SizedBox(height: 30),
            Text("Select Appointment Date", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),

            TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(const Duration(days: 60)),
              focusedDay: selectedDate,
              selectedDayPredicate: (day) => isSameDay(day, selectedDate),
              onDaySelected: (selected, focused) {
                setState(() {
                  selectedDate = selected;
                  selectedTime = null;
                });
              },
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(color: Color(0xFF123458), shape: BoxShape.circle),
                todayDecoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),

            const SizedBox(height: 20),
            Text("Select Time Slot", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: timeSlots.map((slot) {
                final isUnavailable = unavailableSlots.contains(slot);
                final isSelected = selectedTime == slot;

                return ChoiceChip(
                  label: Text(slot),
                  selected: isSelected,
                  onSelected: isUnavailable
                      ? null
                      : (selected) {
                          setState(() => selectedTime = selected ? slot : null);
                        },
                  backgroundColor: isUnavailable ? Colors.grey[300] : null,
                  selectedColor: const Color(0xFF123458),
                  labelStyle: TextStyle(
                    color: isUnavailable ? Colors.grey : (isSelected ? Colors.white : Colors.black),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF123458),
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: selectedTime == null
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Job request sent to ${pro.name} for $selectedTime on ${selectedDate.toLocal().toString().split(' ')[0]}",
                          ),
                        ),
                      );
                    },
              child: Text("Send Job Request", style: GoogleFonts.poppins(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoChipWithLabel(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF123458)),
        const SizedBox(height: 4),
        Text(value, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        Text(label, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}

// 🔍 Placeholder for About Page
class ProfessionalAboutPage extends StatelessWidget {
  final Professional professional;

  const ProfessionalAboutPage({super.key, required this.professional});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About ${professional.name}"),
        backgroundColor: const Color(0xFF123458),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("About", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(
              "This professional has extensive experience in the field and has worked with numerous clients across Hyderabad. More details will be displayed here when available.",
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            const SizedBox(height: 20),
            Text("Verified Skills", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                Chip(label: Text("First Aid")),
                Chip(label: Text("Time Management")),
                Chip(label: Text("Security Surveillance")),
                Chip(label: Text("Driving License")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
