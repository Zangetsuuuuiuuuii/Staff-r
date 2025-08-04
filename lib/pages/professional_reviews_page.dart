import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/professional_review_section.dart';

class ProfessionalReviewsPage extends StatelessWidget {
  final String professionalId;

  const ProfessionalReviewsPage({super.key, required this.professionalId});

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFF1EFEC);
    const primaryColor = Color(0xFF123458);
    const textColor = Color(0xFF030303);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Reviews',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ProfessionalReviewSection(), // Static review section
      ),
    );
  }
}
