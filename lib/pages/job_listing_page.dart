import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/professional.dart';
import 'professional_booking_page.dart';

class JobListingPage extends StatelessWidget {
  final String jobTitle;

  const JobListingPage({super.key, required this.jobTitle});

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFF1EFEC);
    const cardColor = Color(0xFFD4C9BE);
    const primaryColor = Color(0xFF123458);
    const textColor = Color(0xFF030303);

    final professional = Professional(
      id: 031,
      name: 'K Ruthwick',
      jobTitle: 'Driver',
      location: 'ECIL',
      rating: 4.9,
      imageUrl: 'https://robohash.org/quisipsaquam.png?size=50x50&set=set1',
      hourlyRate: 400,
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(jobTitle, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            color: cardColor,
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(professional.imageUrl),
                    radius: 30,
                  ),
                  title: Text(
                    professional.name,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                  subtitle: Text(
                    professional.location,
                    style: GoogleFonts.poppins(
                      color: textColor.withOpacity(0.7),
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      Text(
                        professional.rating.toString(),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfessionalBookingPage(professional: professional),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.green, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        'Verified Professional',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                          fontSize: 13,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '₹${professional.hourlyRate.toStringAsFixed(2)} / hr',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ProfessionalBookingPage(professional: professional),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        'Hire',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}