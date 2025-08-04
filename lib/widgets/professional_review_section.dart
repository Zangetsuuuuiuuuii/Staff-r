import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfessionalReviewSection extends StatelessWidget {
  const ProfessionalReviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    const cardColor = Color(0xFFD4C9BE);
    const primaryColor = Color(0xFF123458);
    const textColor = Color(0xFF030303);

    final List<Map<String, dynamic>> reviews = [
      {
        "reviewerName": "Ruthwick",
        "date": "April 4, 2025",
        "rating": 5,
        "comment": "Extremely professional and punctual. Highly recommend!"
      },
      {
        "reviewerName": "Bhavya",
        "date": "March 29, 2025",
        "rating": 4,
        "comment": "Very reliable and easy to work with. Will hire again."
      },
      {
        "reviewerName": "Tejasree",
        "date": "March 25, 2025",
        "rating": 5,
        "comment": "Excellent service and very polite."
      },
      {
        "reviewerName": "Sumedh",
        "date": "March 20, 2025",
        "rating": 3,
        "comment": "Did a decent job, but communication could be improved."
      },
      {
        "reviewerName": "Adwaith",
        "date": "March 18, 2025",
        "rating": 4,
        "comment": "Clean work and good attitude."
      },
      {
        "reviewerName": "Vaishnavi",
        "date": "March 12, 2025",
        "rating": 5,
        "comment": "Went above and beyond expectations. Would definitely recommend!"
      },
      {
        "reviewerName": "Sanjay",
        "date": "March 8, 2025",
        "rating": 5,
        "comment": "Exceptional service. Friendly and fast!"
      },
    ];

    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];

        return Card(
          color: cardColor,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: primaryColor.withOpacity(0.1), // keep for now
                      child: const Icon(Icons.person, color: primaryColor),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review["reviewerName"] as String,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: textColor,
                          ),
                        ),
                        Text(
                          review["date"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: textColor.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: List.generate(
                        review["rating"] as int,
                        (i) => const Icon(Icons.star,
                            size: 18, color: Colors.amber),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  review["comment"] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
